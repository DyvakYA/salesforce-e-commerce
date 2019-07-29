/**
 * Created by YuriiDyvak on 24.07.2019.
 */

public interface Selector {

    Integer count();

    void deleteOne(sObject entity);

    void deleteAll();

    void deleteAll(List<sObject> entities);

    void deleteById(ID id);

    boolean existsById(ID id);

    List<sObject> findAll();

    List<sObject> findAllById(List<ID> ids);

    sObject findById(ID id);

    void save(sObject entity);

    void saveAll(List<sObject> entities);

    AbstractSelector.SelectorQueryBuilder queryBuilder();

    void setSObjectType(SObjectType type);
}