import React, { FC, useEffect, useState } from "react";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Main from "./routes/main";
import { mintAnimalTokenContract } from "./web3Config";
const App: FC = () => {
  const [account, setAccount] = useState<string>("");

  const getAccount = async () => {
    try {
      if (window.ethereum) {
        const accounts = await window.ethereum.request({
          method: "eth_requestAccounts",
        });

        setAccount(accounts[0]);
      }
    } catch (error) {
      console.error(error);
    }
  };

  const getBalanceOf = async () => {
    const response = await mintAnimalTokenContract.methods
      .balanceOf(account)
      .call();

    console.log(response);
  };

  useEffect(() => {
    getAccount();

    if (account) {
      getBalanceOf();
    }
  }, [account]);

  return (
    <BrowserRouter>
      <Routes>
        <Route path="/" element={<Main />} />
      </Routes>
    </BrowserRouter>
  );
};

export default App;
