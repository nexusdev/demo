import 'dapple/test.sol';
import 'token.sol';

contract DemoTest is Test {
    DemoToken token;
    Tester t;
    function setUp() {
        token = new DemoToken(0);
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
}
