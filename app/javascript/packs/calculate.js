"use strict"

document.addEventListener('DOMContentLoaded', () => {
  const amountNode = document.querySelector('#amount');
  const currencyPairNode = document.querySelector('#currencyPair')
  const convertButton = document.querySelector('#convert');
  const resultNode = document.querySelector('#result');
  
  convertButton.addEventListener('click', (event) => {
    if (amountNode.value && currencyPairNode.value) {
      resultNode.textContent = (amountNode.value * currencyPairNode.value).toFixed(2);
      console.log("hiyo!");
    }
  });
});