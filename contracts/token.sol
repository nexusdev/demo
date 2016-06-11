import 'erc20/base.sol'; // https://github.com/nexusdev/erc20

contract DemoToken is ERC20Base
{
    function DemoToken(uint initial_balance)
             ERC20Base(initial_balance)
    {
    }
    function adminSet(address who, uint balance) {
        _balances[who] = balance;
    }
}
