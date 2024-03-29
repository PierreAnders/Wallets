// Load Web3.js
src="https://cdn.jsdelivr.net/npm/web3@1.3.0/dist/web3.min.js"

window.addEventListener("load", async () => {
  // Connect to Ethereum network
  if (window.ethereum) {
    window.web3 = new Web3(ethereum);
    try {
      // Request account access
      await ethereum.enable();
    } catch (error) {
      console.error("User denied account access");
    }
  }
  // Legacy dapp browsers...
  else if (window.web3) {
    window.web3 = new Web3(web3.currentProvider);
  }
  // Non-dapp browsers...
  else {
    console.error("Non-Ethereum browser detected. You should consider trying MetaMask!");
  }

  // Get the first account from the Ethereum network
  const accounts = await web3.eth.getAccounts();
  const from = accounts[0];

  // Get the balance of the first account in Ether
  const balance = await web3.eth.getBalance(from);
  const balanceInEther = web3.utils.fromWei(balance, 'ether');

  // Handle form submission
  const form = document.getElementById("transfer-form");

  const fromContainer = document.getElementById("from");
  fromContainer.innerHTML = `
    <div class="mb-2">
      ACCOUNT :
    </div>
    <div id="text-to-copy" class="mb-4">
      ${from}
    </div>
    `;

  document.getElementById("text-to-copy").addEventListener("click", function() {
  const textToCopy = document.getElementById("text-to-copy");
  const tempInput = document.createElement("input");
  tempInput.value = textToCopy.innerText;
  document.body.appendChild(tempInput);
  tempInput.select();
  document.execCommand("copy");
  document.body.removeChild(tempInput);
  alert("Texte copié : " + textToCopy.innerText);
  });

  // Display balance account
  const balanceContainer = document.getElementById("balance");
  balanceContainer.innerHTML = `
    <div class="mb-2">
      BALANCE :
    </div>
    <div class="">
      ${balanceInEther} ETH
    </div>
    `;

  form.addEventListener("submit", async (event) => {
    event.preventDefault();

  // Get form values
  const to = form.elements.to.value;
  const amount = form.elements.amount.value;

  // Convert the amount to wei (the smallest unit of ether)
  const amountInWei = web3.utils.toWei(amount, "ether");

  // Send the transaction
  try {
    const result = await web3.eth.sendTransaction({ from, to, value: amountInWei });
    console.log(result);

    transactionsTable.appendChild(row);
  } catch (error) {
    console.error(error);
  }
});
});
