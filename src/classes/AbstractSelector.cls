/**
 * Created by YuriiDyvak on 22.07.2019.
 */

public virtual class AbstractSelector implements Selector {

    private SObjectType obj;

    public AbstractSelector() {
    }

    public AbstractSelector(SObjectType obj) {
        this.obj = obj;
    }

    public void setSObjectType(SObjectType type) {
        this.obj = type;
    }

    public Integer count() {
        String query = '[SELECT COUNT(Id) FROM ' + obj.getDescribe().getLabel() + ']';
        return Database.countQuery(query);
    }

    public void deleteOne(sObject entity) {
        delete entity;
    }

    public void deleteAll() {
        String query = '[SELECT ID FROM ' + obj.getDescribe().getLabel() + ']';
        List<sObject> result = Database.query(query);
        delete result;
    }

    public void deleteAll(List<sObject> entities) {
        delete entities;
    }

    public void deleteById(ID id) {
        String query = '[SELECT ID FROM ' + obj.getDescribe().getLabel() + 'WHERE Id =' + id + ']';
        List<sObject> result = Database.query(query);
        delete result;
    }

    public boolean existsById(ID id) {
        return false;
    }

    public List<sObject> findAll() {
        String query = '[SELECT ID FROM ' + obj + ']';
        return Database.query(query);
    }

    public List<sObject> findAllById(List<ID> ids) {
        String query = '[SELECT ID FROM ' + obj.getDescribe().getName() + 'WHERE Id =' + ids + ']';
        return Database.query(query);
    }

    public sObject findById(Id id) {
        String query = '[SELECT ID FROM ' + obj.getDescribe().getName() + 'WHERE Id =' + id + ']';
        return Database.query(query);
    }

    public sObject findById(String id) {
        String query = '[SELECT ID FROM ' + obj.getDescribe().getName() + 'WHERE Id =' + new SelectorQueryBuilder().getProperId(id) + ']';
        return Database.query(query);
    }

    public void save(sObject entity) {
        insert entity;
    }

    public void saveAll(List<sObject> entities) {
        insert entities;
    }

    public AbstractSelector.SelectorQueryBuilder queryBuilder() {
        return new AbstractSelector.SelectorQueryBuilder();
    }

    public class SelectorQueryBuilder {

        private String QUERY;

        private Integer QUERY_LIMIT;

        public SelectorQueryBuilder querySelect() {
            this.QUERY = 'SELECT ';
            return this;
        }

        public SelectorQueryBuilder queryFields(String fields) {
            this.QUERY += fields;
            return this;
        }

        public SelectorQueryBuilder queryFields(List<String> fields) {
            this.QUERY += String.join(fields, ',');
            return this;
        }

        public SelectorQueryBuilder queryFrom(SObjectType obj) {
            this.QUERY += ' FROM ' + obj.getDescribe().getName();
            return this;
        }

        public SelectorQueryBuilder queryWhere(String name, String value) {
            this.QUERY += ' WHERE ' + name + '=' + getProperId(value);
            return this;
        }

        public SelectorQueryBuilder queryWhere(String name, EqSymbol value) {
            this.QUERY += ' WHERE ' + name + '=' + checkSymbol(value);
            return this;
        }

        public SelectorQueryBuilder queryWhere(String name, EqSymbol symbol, String value) {
            this.QUERY += ' WHERE ' + name + checkSymbol(symbol) + getProperId(value);
            return this;
        }

        private String checkSymbol(EqSymbol symbol) {
            if (symbol == EqSymbol.EQUAL) {
                return '=';
            } else if (symbol == EqSymbol.NOT_EQUAL) {
                return '!=';
            } else if (symbol == EqSymbol.GREATER_OR_EQUAL) {
                return '>=';
            } else if (symbol == EqSymbol.GREATER) {
                return '>';
            } else if (symbol == EqSymbol.LESS) {
                return '<';
            } else if (symbol == EqSymbol.LESS_OR_EQUAL) {
                return '<=';
            } else if (symbol == EqSymbol.IS_NULL) {
                return 'NULL';
            } else {
                throw new TypeException('WRONG SYMBOL EXCEPTION');
            }
        }

        private String getProperId(String id) {
            if (!id.contains('\"'))
                id = '\'' + id + '\'';

            if (id.contains('"'))
                id = id.replace('"', '\'');

            return id;
        }

        public SelectorQueryBuilder queryLimit(Integer queryLimit) {
            this.QUERY_LIMIT = queryLimit;
            this.QUERY += ' LIMIT ' + queryLimit;
            return this;
        }

        public Object execute() {
            System.debug('QUERY : ' + QUERY);
            List<sObject> result = Database.query(QUERY);
            if (QUERY_LIMIT == 1) {
                if (!result.isEmpty()) {
                    return result.get(0);
                } else {
                    return null;
                }
            } else {
                return result;
            }
        }
    }
}