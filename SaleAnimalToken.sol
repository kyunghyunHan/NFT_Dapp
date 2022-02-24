// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "MintAnimalToken.sol";

contract SaleAnimalToken {
    MintAnimalToken public mintAnimalTokenAddress;

    constructor (address _mintAnimalTokenAddress) {
        mintAnimalTokenAddress = MintAnimalToken(_mintAnimalTokenAddress);
    }
    
    mapping(uint256 => uint256) public animalTokenPrices;
    //배열 프론트엔드에서 어떤게 판매중인 토큰인지
    uint256[] public onSaleAnimalTokenArray;
//판매 함수
    function setForSaleAnimalToken(uint256 _animalTokenId, uint256 _price) public {
        //주인이 누군지 출력 토큰아이디 입력하면
        address animalTokenOwner = mintAnimalTokenAddress.ownerOf(_animalTokenId);
        
        //주인이맞으면 통과 틀리면 에러발생
        require(animalTokenOwner == msg.sender, "Caller is not animal token owner.");
        //0보다 작으면 에러발생
        require(_price > 0, "Price is zero or lower.");
        //값이 0 이 아니면 이미 판매등록댐
        require(animalTokenPrices[_animalTokenId] == 0, "This animal token is already on sale.");
        //스마트 컨트렉트에 판매권한을 줫는지 안줫는지
        //isApprovedForAll => 주인이 판매권한을 넘겻는지 , ERC721에서 나옴
        require(mintAnimalTokenAddress.isApprovedForAll(animalTokenOwner, address(this)), "Animal token owner did not approve token.");

        animalTokenPrices[_animalTokenId] = _price;
        
        onSaleAnimalTokenArray.push(_animalTokenId);
    }




     function purchaseAnimalToken(uint256 _animalTokenId) public payable {
        uint256 price = animalTokenPrices[_animalTokenId];
        address animalTokenOnwer = mintAnimalTokenAddress.ownerOf(_animalTokenId);

        require(price > 0, "Animal token not sale.");
        require(price <= msg.value, "Caller sent lower than price.");
        require(animalTokenOnwer != msg.sender, "Caller is animal token owner.");

        payable(animalTokenOnwer).transfer(msg.value);
        mintAnimalTokenAddress.safeTransferFrom(animalTokenOnwer, msg.sender, _animalTokenId);

        animalTokenPrices[_animalTokenId] = 0;

        for(uint256 i = 0; i < onSaleAnimalTokenArray.length; i++) {
            if(animalTokenPrices[onSaleAnimalTokenArray[i]] == 0) {
                onSaleAnimalTokenArray[i] = onSaleAnimalTokenArray[onSaleAnimalTokenArray.length - 1];
                onSaleAnimalTokenArray.pop();
            }
        }
    }

    function getOnSaleAnimalTokenArrayLength() view public returns (uint256) {
        return onSaleAnimalTokenArray.length;
    }
} 