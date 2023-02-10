
include( 'shared.lua' )

for i = 1, 500 do
	surface.CreateFont( "F" .. tostring(i), {
		font = "Teko",
		size = ScreenScale( i )
	})
end

for i = 1, 500 do
	surface.CreateFont( "S" .. tostring(i), {
		font = "Aurek-Besh",
		size = ScreenScale( i )
	})
end