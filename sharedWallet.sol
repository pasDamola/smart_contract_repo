pragma solidity >=0.7.0 <0.9.0;

contract SharedWallet {
    // amount in the wallet
    uint public balance;
    
    struct Account {
        address account;
        bool permitted;
    }
    
    Account[] public permittedAccounts;
    
    function giveAccountPermission(Account memory _account) public {
        require(_account.permitted == true, "You have already been granted permission to use this account");
        _account.permitted = true;
        permittedAccounts.push(Account({
            account: _account.account,
            permitted: _account.permitted
        }));
    }
    

    function withdrawMoney(address payable _to, uint _amount) public {
        _to.transfer(_amount);
    }
    
    function deposit(uint _amount) public  {
        require((_amount + balance) > balance, "Deposit not successful");
        balance += _amount;
    }
    
    // make sure the address calling the function has the permission to withdraw
    // mkae sure what they are withdrawing is what they are allowed to withdraw;

    receive() external payable {

    }
}