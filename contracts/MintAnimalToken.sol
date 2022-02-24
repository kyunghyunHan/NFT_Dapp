pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";


contract MintAnimalToken is ERC721Enumerable {
    constructor() ERC721("h662Animals", "HAS") {} //한번 실행 //name symbol

    mapping(uint256 => uint256) public animalTypes;

    function mintAnimalToken() public {
        uint256 animalTokenId = totalSupply() + 1;

        uint256 animalType = uint256(keccak256(abi.encodePacked(block.timestamp, msg.sender, animalTokenId))) % 5 + 1;
         //랜덤하게
        animalTypes[animalTokenId] = animalType; 
//animalTokenId = nft가 가지는 유일한 값
//totalSupply = 민팅된 nft양
//msg.sender -> minting누른사람
        _mint(msg.sender, animalTokenId);//ERC721 ->에서 지원
    }
} 