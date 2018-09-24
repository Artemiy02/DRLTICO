pragma solidity ^0.4.24;

import "./Ownable.sol";

contract DataRootLabsToken is Ownable {

  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;
  address public appContract;

  mapping (address => uint256) public balanceOf;
  mapping (address => mapping(address => uint256)) public allowance;

  event Transfer(address from, address to, uint256 value);
  event Approval(address from, address to, uint256 value);

  constructor() public {
    decimals = 8;
    totalSupply = 10000000 * (10 ** uint256(decimals));
    balanceOf[msg.sender] = totalSupply;
    name = "DataRootLabsToken";
    symbol = "DRLT";
  }

  function _transfer(address _from, address _to, uint256 _value) internal {
    require(_to != address(0));
    require(balanceOf[_from] >= _value);
    require(balanceOf[_to] + _value >= balanceOf[_to]);
    balanceOf[_from] -= _value;
    balanceOf[_to] += _value;
    emit Transfer(_from, _to, _value);
  }

   function transfer(address _to, uint256 _value) public {
     _transfer(msg.sender, _to, _value);
   }


   function setAppContract(address _app) onlyOwner public {
     appContract = _app;
   }

   function payment(address _from, uint256 _value) public returns (bool) {
     require(msg.sender == appContract);
     if (balanceOf[_from] >= _value) {
         balanceOf[appContract] += _value;
         balanceOf[_from] -= _value;
         return true;
     }
     else {
         return false;
     }
   }
}
