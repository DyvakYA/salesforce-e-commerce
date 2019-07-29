/**
 * Created by YuriiDyvak on 23.07.2019.
 */

public class Factory {

    public class ServiceFactory {

        private Map<Type, Type> services;

        private sObject mock;

        public ServiceFactory(Map<Type, Type> services) {
            this.services = services;
        }

        public Object get(Type key) {
            // Mock?
            if (mock != null)
                return mock;
            Type type = services.get(key);
            return type.newInstance();
        }

        public void setMock(sObject mock) {
            this.mock = mock;
        }
    }

    public class UtilFactory {

        private Map<Type, Type> utils;

        private sObject mock;

        public UtilFactory(Map<Type, Type> utils) {
            this.utils = utils;
        }

        public Object get(Type key) {
            // Mock?
            if (mock != null)
                return mock;
            Type type = utils.get(key);
            return type.newInstance();
        }

        public void setMock(sObject mock) {
            this.mock = mock;
        }
    }

    public class SelectorFactory {

        private Map<SObjectType, Type> selectors;

        private Selector mock;

        public SelectorFactory(Map<SObjectType, Type> selectors) {
            this.selectors = selectors;
        }

        public Selector get(SObjectType key) {
            // Mock?
            if (mock != null)
                return mock;
            Type type = selectors.get(key);
            Selector selector = (Selector) type.newInstance();
            selector.setSObjectType(key);
            return selector;
        }

        public void setMock(Selector mock) {
            this.mock = mock;
        }
    }
}