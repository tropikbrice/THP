function calculator() {
	var keyz = document.querySelectorAll('.keys');

	let add = function( x, y){ return x+y};
	let multiply = function( x, y){ return x*y};
	let divide = function( x, y){ return x/y};
	let subtract = function( x, y){ return x-y};

	var tab = [];

	for(let i=0; i< keyz.length; i++) {
		let key = keyz[i];
		if (key !="=") {
		};
		tab.push(key.innerText);
		let calculous = function(){
			console.log(key.innerText);
				// console.log( parseInt(key.innerText,10) ) ;
			};

			console.log(tab);
	//on ecoute les "keys" de la calculatrice
	key.addEventListener('click',calculous);
}
};
calculator();