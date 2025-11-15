local plugin = {}

plugin.name = "RPG Encounter Shuffler"
plugin.author = "authorblues and kalimag (MMDS), Phiggle, Rogue_Millipede, Shadow Hog, expeditedDelivery, Smight, endrift, ZoSym, Extreme0, L Thammy (Chaos Damage Shuffler), AshenStrix"
plugin.minversion = "2.6.3"
plugin.settings =
{
	{ name='SuppressLog', type='boolean', label='Suppress "ROM unrecognized"/"on Level 1" logs'},
	{ name='DebugSingleGame', type='boolean', label='Debugging: Rearm the shuffler logic even if no new game was loaded' },
	{ name='grace', type='number', label="Minimum grace period before swapping (won't go < 10 frames)", default=10 },
	{ name='BaseSwapChance', type='number', label="Percent chance, increasing linearly, of an encounter triggering a swap", default=100},
	{ name='SwapChanceIncrease', type='boolean', label="Increase chance with every suppressed swap", default=true},
	{ name='SwapChanceIncreaseAmount', type='number', label="Percent to increment swap chance with each encounter", default=5},
}

plugin.description =
[[
	This is the prototype of an offshoot of the Damage Shuffler, made to allow for adding RPGs to the logic.
	Right now it only supports swapping on hitting a random encounter, but more logic is planned.
	Currently supports FF3 US and FF2 US, will add many more games as time goes on.

]]

local NO_MATCH = 'NONE'

-- debugging settings
local PAUSE_ON_SWAP = false -- pause whenever a swap would occur

local tags = {}
local tag
local gamemeta
local prevdata
local debug_timer
local swap_scheduled
local shouldSwap
local prev_framecount
local swap_chance

--returns true if the die roll determines we should still swap if the swap requirements are met, then increases the chance if it fails
--if it succeeds, resets the swap chance
local function checkRandomSwap(settings)
	if settings.BaseSwapChance ~= 100 and swap_chance < 100 then
		if math.random(100) >= swap_chance then 
			swap_chance = settings.SwapChanceIncrease and (swap_chance + settings.SwapChanceIncreaseAmount) or swap_chance
			log_console('Current Swap Chance: ' .. swap_chance)
			return false
			-- don't swap
		end
	end
	swap_chance = settings.SwapChance
	return true
end

-- update value in prevdata and return whether the value has changed, new value, and old value
-- value is only considered changed if it wasn't nil before
local function update_prev(key, value)
	if key == nil or value == nil then
		error("update_prev requires both a key and a value")
	end
	local prev_value = prevdata[key]
	prevdata[key] = value
	local changed = prev_value ~= nil and value ~= prev_value
	return changed, value, prev_value
end

local function encounter_swap(gamemeta)
	return function()
		local encounterChanged, curInEncounter = update_prev('encounterStatus', gamemeta.inEncounter())
		return encounterChanged and curInEncounter
	end
end

local function ff2nes_swap(gamemeta)
	return function()
		local isChanged, curValue, prevValue = update_prev('ff2Transition', gamemeta.transitionCounter())
		return isChanged and (curValue == 0x0041) and (prevValue == 0x0040)
	end
end

local gamedata = {
	['FF1_NES']={ -- Final Fantasy 1 NES
		func=encounter_swap,
		inEncounter=function() return memory.read_u8(0x0081, "RAM") == 0x063 end, --TODO:
		--logfunc=function() log_console('ff1 memory: ' .. memory.read_u16_le(0x000684, "WRAM")) end,
	},
	['FF2_NES']={ -- Final Fantasy 2 NES
		func=ff2nes_swap,
		transitionCounter=function() return memory.read_u8(0x008C, "RAM") end, --TODO:
		--[[logfunc=function()
			if(curValue ~= nil and prevValue ~= nil) then
			 log_console('ff2 memory: ' .. memory.read_u8(0x008C, "RAM") .. ' curValue: ' .. curValue .. ' prevValue: ' .. prevValue)
			end
		end,]]
	},
	['FF3_NES']={ -- Final Fantasy 3 NES
		func=encounter_swap,
		inEncounter=function() return memory.read_u8(0x0001, "RAM") == 0x0001 end, --TODO:Fix Swap when starting credits sequence
		--logfunc=function() log_console('ff3 memory: ' .. memory.read_u16_le(0x000684, "WRAM")) end,
	},
	['FF4_SNES']={ -- Final Fantasy 4 SNES
		func=encounter_swap,
		inEncounter=function() return memory.read_u16_le(0x116e0, "WRAM") == 0x0100 end, --TODO: Look for logic that swaps when battle starts (after zoom-in, ideally during black screen)
		--logfunc=function() log_console('ff4 memory: ' .. memory.read_u16_le(0x000684, "WRAM")) end,
	},
	['FF5_GBA']={ -- Final Fantasy 5 GBA
		func=encounter_swap,
		--inEncounter=function() return memory.read_u16_le(0x0096E0, "EWRAM") == 0x0011 end, --TODO: Try transition from 0x0011 -> 0x000A
		inEncounter=function() return memory.read_u8(0x96E0, "EWRAM") == 0x0011 end, --TODO: Try transition from 0x0011 -> 0x000A
		--logfunc=function() log_console('ff5 memory: ' .. memory.read_u8(0x96E0, "EWRAM")) end,
	},
	['FF6_SNES']={ -- Final Fantasy 6 SNES
		func=encounter_swap,
		inEncounter=function() return memory.read_u16_le(0x000054, "WRAM") == 0xFF00 end,
		--logfunc=function() log_console('ff6 memory: ' .. memory.read_u16_le(0x000054, "WRAM")) end,
	},

}

local backupchecks = {
}

local function get_game_tag()
	-- try to just match the rom hash first
	local tag = get_tag_from_hash_db(gameinfo.getromhash(), 'plugins/encounter-shuffler-hashes.dat')
	if tag ~= nil and gamedata[tag] ~= nil then
		return tag
	end

	-- check to see if any of the rom name samples match
	local name = gameinfo.getromname()
	for _,check in pairs(backupchecks) do
		if check.test() then
			return check.tag
		end
	end

	return nil
end

function plugin.on_game_load(data, settings)
	prevdata = {}
	debug_timer = 0
	swap_scheduled = false
	shouldSwap = function() return false end

	prev_framecount = emu.framecount()

	tag = tags[gameinfo.getromhash()] or get_game_tag()
	tags[gameinfo.getromhash()] = tag or NO_MATCH

	-- ONLY APPLY THESE TO RECOGNIZED GAMES
	-- ONLY APPLY THESE TO RECOGNIZED GAMES
	-- ONLY APPLY THESE TO RECOGNIZED GAMES

	-- TODO: set min and max level variable by game

	-- first time through with a bad match, tag will be nil
	-- can use this to print a debug message only the first time

	if tag ~= nil and tag ~= NO_MATCH then
		gamemeta = gamedata[tag]
		local func = gamemeta.func
		shouldSwap = func(gamemeta)
		swap_chance = settings.BaseSwapChance
		math.randomseed(os.time())
	else
		gamemeta = nil
	end

	-- log stuff
	if tag ~= nil then 
		log_console('Encounter Shuffler: recognized as ' .. string.format(tag))
	elseif tag == nil or tag == NO_MATCH then
		if settings.SuppressLog ~= true then
			log_console(string.format('Encounter Shuffler: unrecognized - do you have encounter-shuffler-hashes.dat? %s (%s)',
			gameinfo.getromname(), gameinfo.getromhash())) end
	end
end

function plugin.on_frame(data, settings)
	-- Detect resets, savestate load or rewind (or turbo if "Run lua scripts when turboing" is disabled)
	local inputs = joypad.get()
	local new_framecount = emu.framecount()
	if inputs.Reset or inputs.Power or new_framecount ~= prev_framecount + 1 then
		prevdata = {} -- reset prevdata to avoid swaps
	end
	prev_framecount = new_framecount

	-- TODO: CAN WE MAKE THIS A FUNCTION AND CALL IT WHEN WE NEED IT

	-- avoiding super short swaps (<10) as a precaution
	local grace = math.max(gamemeta and gamemeta.grace or 0, settings.grace, 10)

	if settings.DebugSingleGame and swap_scheduled then
		debug_timer = debug_timer + 1
		-- rearm the shuffler even though no on_load happened to reset things
		if debug_timer > grace then
			prevdata = {}
			debug_timer = 0
			swap_scheduled = false
		end
	end

	-- run the check method for each individual game

	if not swap_scheduled then

		-- PROCESS "DON'T SWAP" SETTINGS HERE
		-- A function like this should be generalizable for other games in the future to make exceptions 
		-- so that users can turn off specific swap conditions
		-- laid out by a DisableExtraSwaps function

		-- AND NOW WE SWAP
		local schedule_swap, delay = shouldSwap(prevdata)
		if schedule_swap and frames_since_restart > grace and checkRandomSwap(settings) then
			delay = delay or 3
			debug_timer = -delay
			swap_game_delay(delay)
			swap_scheduled = true
			if not settings.SuppressLog or settings.DebugSingleGame then
				log_console('Encounter Shuffler: swap scheduled for %s (frame: %d, delay: %d)', tag, frames_since_restart, delay)
			end
			if PAUSE_ON_SWAP then client.pause() end
		end
	end
end

return plugin