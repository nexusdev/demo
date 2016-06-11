import 'erc20/base.sol'; // https://github.com/nexusdev/erc20
import 'component.sol';

contract DemoToken is ERC20Base
                    , Component
{
    function DemoToken(uint initial_balance, ComponentManager manager)
             ERC20Base(initial_balance)
             Component(manager)
    {
    }
    function setBalance(address who, uint balance)
        auth
    {
        _balances[who] = balance;
    }
}
