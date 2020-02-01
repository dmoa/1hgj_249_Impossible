local Map = {
    image = lg.newImage("tileset.png"),
    tileL = 16,
    mapTileLength = 8,
    tileQuads = {},
    mapData = {}
}

for i = 0, Map.image:getWidth() / Map.tileL - 1 do
    table.insert(Map.tileQuads, lg.newQuad(i * Map.tileL, 0, Map.tileL, Map.tileL, Map.image:getDimensions()))
end

for i = 1, 8 do
    table.insert(Map.mapData, {})
    for j = 1, 20 do
        table.insert(Map.mapData[i], 0)
    end
end

for i = 1, 8 do
    Map.mapData[1][i] = lm.random(9, 10)
    Map.mapData[8][i] = lm.random(9, 10)
end

function Map:draw()
    lg.setColor(51 / 255, 153 / 255, 1)
    lg.rectangle("fill", 0, 0, gameWidth, gameHeight)
    lg.setColor(1, 1, 1)

    for x, column in ipairs(self.mapData) do
        for y, tileValue in ipairs(column) do
            if tileValue ~= 0 then
                lg.draw(self.image, self.tileQuads[tileValue], (x - 1) * self.tileL, (y - 1) * self.tileL)
            end
        end
    end
end

function Map:generateTiles()
    for i = 8, 1, -1 do
        if (i + 1) % 3 == 0 then
            -- grass
            local startingGrassIndex = lm.random(2, 7)
            local endingGrassIndex = lm.random(startingGrassIndex, 7)
            if startingGrassIndex == endingGrassIndex then
                Map.mapData[startingGrassIndex][i] = 8
            else
                Map.mapData[startingGrassIndex][i] = 5
                Map.mapData[endingGrassIndex][i] = 7
                for j = startingGrassIndex + 1, endingGrassIndex - 1 do
                    Map.mapData[j][i] = 6
                end
            end
            -- stone
            if startingGrassIndex > 2 then
                if startingGrassIndex == 3 then
                    Map.mapData[2][i] = 4
                else
                    Map.mapData[2][i] = 1
                    Map.mapData[startingGrassIndex - 1][i] = 3
                    for j = 3, startingGrassIndex - 2 do
                        Map.mapData[j][i] = 2
                    end
                end
            end
            if endingGrassIndex < 7 then
                if endingGrassIndex == 6 then
                    Map.mapData[7][i] = 4
                else
                    Map.mapData[endingGrassIndex + 1][i] = 1
                    Map.mapData[7][i] = 3
                    for j = endingGrassIndex + 2, 6 do
                        Map.mapData[j][i] = 2
                    end
                end
            end
        end
    end
end

function Map:update(dt)
end

return Map