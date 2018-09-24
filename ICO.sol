pragma solidity ^0.4.24;

interface Token {
  function transfer(address _reciever, uint _amount) external;
}

contract ICO {
  uint public buyPrice;
  address private wallet;
  Token public token;

  constructor(Token _token) public {
    token = _token;
    wallet = msg.sender;
    buyPrice = 1000000 wei;
  }

  function () payable public {
    _buy(msg.sender, msg.value);
  }

  function buy() payable public returns (uint) {
    uint tokens = _buy(msg.sender, msg.value);
    return tokens;
  }

  function _buy(address _sender, uint256 _amount) internal returns (uint) {
    uint tokens = _amount / buyPrice;
    token.transfer(_sender, tokens);
    wallet.transfer(msg.value);
    return tokens;
  }
}
