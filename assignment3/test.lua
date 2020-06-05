 --for i =1, 8 do
    
        --for j=1,8 do
        local i =1
        local j =1
        if not swap_possible and self.tiles[i][j] ~= nil then
            
            local swap_tile = self.tiles[i][j]
            
            local newTile = self.tiles[i][j+1]


            local tempX = newTile.gridX
            local tempY = newTile.gridY
        
        
            newTile.gridX = swap_tile.gridX
            newTile.gridY = swap_tile.gridY
            swap_tile.gridX = tempX
            swap_tile.gridY = tempY
        
            -- swap tiles in the tiles table
            self.tiles[swap_tile.gridY][swap_tile.gridX] =
                swap_tile
        
            self.tiles[newTile.gridY][newTile.gridX] = newTile

            local tester = Board:calculateMatches()

            if not tester then
                tempX = newTile.gridX
                tempY = newTile.gridY
            
            
                newTile.gridX = swap_tile.gridX
                newTile.gridY = swap_tile.gridY
                swap_tile.gridX = tempX
                swap_tile.gridY = tempY
            
                -- swap tiles in the tiles table
                self.tiles[swap_tile.gridY][swap_tile.gridX] =
                    swap_tile
            
                self.tiles[newTile.gridY][newTile.gridX] = newTile
            else 
                swap_possible = true
            end


        end 

        if not swap_possible then
            local swap_tile = self.tiles[i][j]
            
            local newTile = self.tiles[i+1][j]


            local tempX = newTile.gridX
            local tempY = newTile.gridY
        
        
            newTile.gridX = swap_tile.gridX
            newTile.gridY = swap_tile.gridY
            swap_tile.gridX = tempX
            swap_tile.gridY = tempY
        
            -- swap tiles in the tiles table
            self.tiles[swap_tile.gridY][swap_tile.gridX] =
                swap_tile
        
            self.tiles[newTile.gridY][newTile.gridX] = newTile

            local tester = Board:calculateMatches()

            if not tester then
                tempX = newTile.gridX
                tempY = newTile.gridY
            
            
                newTile.gridX = swap_tile.gridX
                newTile.gridY = swap_tile.gridY
                swap_tile.gridX = tempX
                swap_tile.gridY = tempY
            
                -- swap tiles in the tiles table
                self.tiles[swap_tile.gridY][swap_tile.gridX] =
                    swap_tile
            
                self.tiles[newTile.gridY][newTile.gridX] = newTile
            else 
                swap_possible = true
            end

        end 
   -- end

-- end
