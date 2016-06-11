import 'component.sol';
import 'token.sol';
import 'controller.sol';
import 'datastore.sol';

contract DemoTokenFactory {
    function newDemoSystem() returns (ComponentManager m) {
        var manager = new ComponentManager();

        var token = new DemoTokenFrontend(manager);
        var controller = new DemoTokenController(manager);
        var db = new DemoTokenDB(manager);

        manager.setRoot(token, true);
        manager.setRoot(controller, true);
        manager.setRoot(db, true);

        manager.setEnv("frontend", bytes32(address(token)));
        manager.setEnv("controller", bytes32(address(controller)));
        manager.setEnv("db", bytes32(address(db)));

        token.refreshEnvironment();
        controller.refreshEnvironment();

        manager.setRoot(msg.sender, true);
        manager.setRoot(this, false);
        return manager;
    }
}
