pragma solidity >=0.7.0 <0.9.0;


// smart contract for a banking application
contract Bank {
    address payable public owner;
    mapping(address => uint) private balances;
    event Deposited(uint amount, address account);
    event Withdrawal(uint amount, address account);
    event Transferred(uint amount, address account);
    
    constructor () payable {
        owner = payable(msg.sender);
    }
    
    function getBalance(address account) public view returns (uint) {
        return balances[account];
    }
    
    
    function deposit(uint amount) public payable returns(uint) {
        require((balances[msg.sender] + amount) > balances[msg.sender], "You do not have authoriazation to deposit into this account");
        balances[msg.sender] += amount;
        
        emit Deposited(amount, msg.sender);
        
        return balances[msg.sender];
    }
    
    function withdraw(uint amount) public payable {
        require(owner == msg.sender, "You do not have authoriazation to withdraw from this account");
        require(balances[msg.sender] >= amount, "You don't have sufficient funds for this withdrawal");
        
        balances[msg.sender] -= amount;
    
        emit Withdrawal(amount, msg.sender);
        
    }
    
    
    function transfer(uint amount, address to) public payable {
        require(balances[msg.sender] >= amount, "You don't have sufficient funds for this transfer");
        
        balances[msg.sender] -= amount;
        balances[to] += amount;
        
        emit Transferred(amount, to);
    }
}