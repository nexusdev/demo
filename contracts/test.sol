import 'dapple/test.sol';
import 'token.sol';

contract DemoTest is Test {
    DemoToken token;
    Tester t;
    ComponentManager manager;
    function setUp() {
        manager = new ComponentManager();
        token = new DemoToken(0, manager);
        t = new Tester();
        t._target(token);
    }
    function testSetBalance() {
        token.setBalance(this, 100);
        assertEq(100, token.balanceOf(this));
    }
    function testFailNonAdminSetBalance() { // `testFail` detects throws
        DemoToken(t).setBalance(this, 100); // throws
    }
    function testComponentManagerGrantRoot() {
        manager.setRoot(t, true);
        DemoToken(t).setBalance(t, 100);
        assertEq(100, token.balanceOf(t));
    }
}
