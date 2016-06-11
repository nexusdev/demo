import 'dapple/test.sol';
import 'erc20/erc20.sol';
import 'token.sol';
import 'datastore.sol';
import 'controller.sol';
import 'installer.sol';

contract DemoTest is Test {
    DemoTokenFactory factory;
    DemoTokenFrontend token;
    DemoTokenController controller;
    DemoTokenDB db;
    Tester t;
    ComponentManager manager;
    Whitelist whitelist;
    function setUp() {
        factory = new DemoTokenFactory();
        manager = factory.newDemoSystem();

        manager.setRoot(factory, true);
        factory.updateDemoSystemWithWhitelist(manager);
        manager.setRoot(factory, false);

        token = DemoTokenFrontend(address(manager.getEnv("frontend")));
        controller = DemoTokenController(address(manager.getEnv("controller")));
        db = DemoTokenDB(address(manager.getEnv("db")));
        whitelist = Whitelist(address(manager.getEnv("whitelist")));

        t = new Tester();
        t._target(token);
    }
    function testCanTransferToWhitelisted() {
        db.setBalance(this, 100); // hack in to give self balance
        assertFalse(whitelist.allowed(t));
        whitelist.setAllowed(t, true);
        assertTrue(whitelist.allowed(t));
        manager.setRoot(this, false);
        token.transfer(t, 50);
        assertEq(token.balanceOf(this), 50);
        assertEq(token.balanceOf(t), 50);
    }
    function testFailCantTransferToUnWhitelisted() {
        db.setBalance(this, 100); // hack in to give self balance
        assertFalse(whitelist.allowed(t));
        manager.setRoot(this, false);
        token.transfer(t, 50);
        assertEq(token.balanceOf(t), 50); // doesn't reach here
    } 
    // Old tests now manipulate DB directly - need new tests using frontend
    function testSetBalance() {
        db.setBalance(this, 100);
        assertEq(100, token.balanceOf(this));
    }
    function testFailNonAdminSetBalance() { // `testFail` detects throws
        t._target(db);
        DemoTokenDB(t).setBalance(this, 100); // throws
    }
    function testComponentManagerGrantRoot() {
        manager.setRoot(t, true);
        t._target(db);
        DemoTokenDB(t).setBalance(t, 100);
        assertEq(100, token.balanceOf(t));
    }
}
