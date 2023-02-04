document.getElementById("text-to-copy").addEventListener("click", function() {
  const textToCopy = document.getElementById("text-to-copy");
  const tempInput = document.createElement("input");
  tempInput.value = textToCopy.innerText;
  document.body.appendChild(tempInput);
  tempInput.select();
  document.execCommand("copy");
  document.body.removeChild(tempInput);
  alert("Copied text : " + textToCopy.innerText);
});
