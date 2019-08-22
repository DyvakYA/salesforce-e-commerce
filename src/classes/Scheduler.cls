/**
 * Created by YuriiDyvak on 20.08.2019.
 */

public with sharing class Scheduler {

    Map<String, Object> scheduler = new Map<String, Object>{
            '00 00 0 * * ?' => new ScheduleSprintEndDate()
    };

    public void execute() {
        for (String key : scheduler.keySet()) {
            String jobID = System.schedule(scheduler.get(key).toString(), key, (Schedulable) scheduler.get(key));
        }
    }
}