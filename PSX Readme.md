To add multi-disc PSX games to the shuffler, you'll need to use Bizhawk's Multi-disk Bundler.

It should output something similar to this (make sure you use the .cue files instead of the .bin)

```xml
<BizHawk-XMLGame System="PSX" Name="Final Fantasy IX">
  <LoadAssets>
    <Asset FileName="..\..\PSX\Final Fantasy IX (USA, Canada) (Disc 1).cue" />
    <Asset FileName="..\..\PSX\Final Fantasy IX (USA, Canada) (Disc 2).cue" />
    <Asset FileName="..\..\PSX\Final Fantasy IX (USA, Canada) (Disc 3).cue" />
    <Asset FileName="..\..\PSX\Final Fantasy IX (USA, Canada) (Disc 4).cue" />
  </LoadAssets>
</BizHawk-XMLGame>
```

You will probably need to edit the file paths to point from the games folder once you move the xml there.

You can find the required filenames in the backupchecks portion of rpg-encounter-shuffler.lua. For now, the only 3 implemented PSX games are Final Fantasy 7-9, which should have a filename of the format "Final Fantasy <VII/VIII/IX>.xml"