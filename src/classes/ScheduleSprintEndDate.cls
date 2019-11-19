/**
 * Created by YuriiDyvak on 20.08.2019.
 */



public class ScheduleSprintEndDate implements Schedulable {

    public void execute(SchedulableContext param1) {
        Id bachId = Database.executeBatch(new SchedulerCheckIfSprintDateEndBatch());
    }
}