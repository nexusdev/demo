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
    function setUp() {
        factory = new DemoTokenFactory();
        manager = factory.newDemoSystem();
        token = DemoTokenFrontend(address(manager.getEnv("frontend")));
        controller = DemoTokenController(address(manager.getEnv("controller")));
        db = DemoTokenDB(address(manager.getEnv("db")));
        t = new Tester();
        t._target(token);
    }
    function testTransferOnFrontend() {
        db.setBalance(this, 100); // hack in to give self balance
        manager.setRoot(this, false);
        token.transfer(t, 50);
        assertEq(token.balanceOf(this), 50);
        assertEq(token.balanceOf(t), 50);
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
