-- erasing previous function if exists
if object_id('dbo.selectcomtradecode') is not null 
begin drop function dbo.selectcomtradecode end
go