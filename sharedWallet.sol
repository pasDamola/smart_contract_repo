pragma solidity >=0.7.0 <0.9.0;

contract SharedWallet {
    // amount in the wallet
    uint public balance;
    uint public maxWithdrawalAmount = 100;
    
    struct Account {
        address payable account;
        bool permitted;
        uint amountToWithdraw;
    }
    
    Account[] public permittedAccounts;
    
    function getAccountIndex(address _addr) public view returns (uint i) {
    for(uint _i = 0; _i< permittedAccounts.length; _i++){
      if(_addr == permittedAccounts[_i].account) {
             return _i;
      }
   
    }
  }
    
    modifier onlyPermittedAccount(address _addr) {
        uint accountIndex = getAccountIndex(_addr);
        require(permittedAccounts[accountIndex].permitted, "Acount not permitted.");
        _;
    }
    
    modifier onlyWithdrawalAmount(address _addr) {
        uint accountIndex = getAccountIndex(_addr);
        require(permittedAccounts[accountIndex].amountToWithdraw >= maxWithdrawalAmount);
        _;
    }
    
    function giveAccountPermission(Account memory _account) public {
        require(_account.permitted == true, "You have already been granted permission to use this account");
        _account.permitted = true;
        permittedAccounts.push(Account({
            account: _account.account,
            permitted: _account.permitted,
            amountToWithdraw: _account.amountToWithdraw
        }));
    }
    

    function withdrawMoney(address payable _to, uint _amount) public onlyPermittedAccount(_to) onlyWithdrawalAmount(_to) {
        _to.transfer(_amount);
        
        balance -= _amount;
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