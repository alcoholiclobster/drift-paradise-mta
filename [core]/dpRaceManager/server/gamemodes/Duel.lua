Duel = RaceGamemode:subclass "Duel"

-- Дуэль
-- Финиш - один игрок доехал
-- Победитель - первый приехавший
-- Особенности:
-- Первый игрок доехал - оставляем 15 секунд

function Duel:init(...)
	self.super:init(...)
end

function Duel:raceFinished(timeout)
	self.super:raceFinished(timeout)
	
	if timeout then
		for i, player in ipairs(self.race:getPlayers()) do
			self.race:removePlayer(player)
		end
	end
end

function Duel:playerRemoved(player)
	self.super:playerRemoved(player)

	local players = self.race:getPlayers()
	if #players > 0 then
		triggerEvent("RaceDuel.duelFinished", self.race.element, players[1])
	end

	self.race:destroy()
end

function Duel:playerFinished(player)
	triggerEvent("RaceDuel.duelFinished", self.race.element, player)
	self.race:destroy()
end