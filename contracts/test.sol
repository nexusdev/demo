import 'dapple/test.sol';
import 'token.sol';

contract DemoTest is Test {
    DemoToken token;
    function setUp() {
        token = new DemoToken(0);
    }
    function testAdminSet() {
        token.adminSet(this, 100);
        assertEq(100, token.balanceOf(this));
    }
}
