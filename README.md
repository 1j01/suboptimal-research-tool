
# Suboptimal Research Tool <sup style="opacity:0.1">&copy;</sup>

"Research" topics automatically — <img alt="powered by Google" src="https://maps.gstatic.com/mapfiles/api-3/images/powered-by-google-on-white2.png" align="
center">'s autocomplete.

(This is the *wrong way* to use Google for research, FYI.)

### Installation
`npm i suboptimal-research-tool -g`

### CLI Usage

`research cats` (pluralization shouldn't matter)

```
Hey, look, a cat!

I think cats are...
   cute
   weird
   curious
   lazy
   flexible
   evil
   stupid
   nocturnal
   sleepy
   funny

What do cats do? They...
   purr
   meow
   sleep
   eat grass
   hate water
   hiss
   bite
   drool
   knead
   sneeze
   spray
   love boxes
   pant
   chirp
   wag tails

There is a curious cat.
There is a lazy cat.
There is a funny, lazy, evil cat.
There is a lazy, evil, cute cat.
There is a funny, weird, flexible cat.
There is a cute, evil, sleepy cat.

A weird cat drooled.
A cute cat bit.
A funny, cute cat hissed.
A funny, stupid, evil cat hated water.
A sleepy cat panted.
A weird cat meowed.
```

### Module Usage

If you have some use for this, here it is!

```js
var research = require("suboptimal-research-tool");
research("bats", function(err, subject){
	if(err){
		return console.error(err);
	}
	console.log(
		subject.singular, // "bat"
		subject.plural, // "bats"
		subject.adjectives, // ["scary", etc.]
		subject.verbs // ["hibernate", etc.]
	);
});
```

### About

This module asks [Google's autocomplete team](https://www.youtube.com/watch?v=blB_X38YSxQ) what people search for in relation to a given subject.
Specifially, it finds what people have asked in the form of `Why are <SUBJECTs>...?` (hoping for adjectives) and `Why do <SUBJECTs>...?` (hoping for verb phrases).

Because of the way the results are procured, they are prone to include misconceptions, stereotypes and opinions.

For instance, people search for "why are zebras extinct", so this module blindly assumes zebras are extinct.
