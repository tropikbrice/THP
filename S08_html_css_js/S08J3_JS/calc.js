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

		let calculous = function(){
			console.log(this);
			console.log(tab);

			keyz[i].addEventListener('click',calculous); //on ecoute les "keys" de la calculatrice
		}
	};
};
calculator();


// tab.push(key.innerText);

	// var tab = [];
	// for(let i=0; i< keyz.length; i++) {
	// 	let key = keyz[i];
		
	// 	let calculous = function(){
	// 		console.log(key.innerText);
	// 		tab.push(key.innerText);
	// 	// console.log( parseInt(key.innerText,10) ) ;
	// };

	// 	//on ecoute les "keys" de la calculatrice
	// keyz.addEventListener('click',function(){
	// 	console.log(this.innerText);
	// });