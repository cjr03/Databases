DROP VIEW IF EXISTS Heart_rate_view;
CREATE VIEW Heart_rate_view AS
SELECT o.observation_id, ob.phlid, ph.name, o.rate AS heart_rate, ob.manufacturer, ob.model, ob.kind, ob.software_version           
FROM Observable o
JOIN Observer ob ON o.observer_id = ob.observer_id
JOIN PHLogger ph ON ob.phlid = ph.phlid
WHERE o.kind = 'heartrate';     
