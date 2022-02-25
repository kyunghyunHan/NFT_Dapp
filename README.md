# NFT_Dapp
## 기술 
- 솔리디티
- Open Zeppelin 
- React
- chakra
- web3.js
---

< 이더를 보내는 3가지 >
    1. send : 2300 gas 를 소비함, 성공여부를 true 또는 false로 리턴 (에러를 보내지 못하는 단점.)
    2. transfer : 2300  gas를 소비 (gas값 지정 가능), 싷패시 에러를 발생. (3가지방법중 가장 안전.)
    3. call : 가변적인 gas 소비 (gas값 지정가능), 성공여부를 true 또는 false로 리턴.
              그러나, 재진입(reentrancy)공격 위험성 있음, 
              2019년 12월 이후 call사용 추천 => 2300 가스양이 부족할 가능성이 있기에
              >> 가스양 지정이 가능한데 가스 금액이 더 오를 수 있기에 금액을 지정하지 않는게 이득일 수도
              
---
## 설치
GitHub https://github.com/h662/h662Animals-contracts/commit/e906e831d2ab199b9cd6b5832f8e61412b2107cd 

Visual Studio Code https://code.visualstudio.com/Download 

NodeJS https://nodejs.org/ko/download/ 

Remix IDE https://remix.ethereum.org/

---

```
 npm install @openzeppelin/contracts
```
test 
```
remixed - s. —remix-ide https://remix.ethereum.org
```
```
npm i @chakra-ui/react @emotion/react@^11 @emotion/styled@^11 framer-motion@^6
```