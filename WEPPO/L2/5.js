let obiekt = {
    pole: 'value',

    metoda: function(){
        console.log('hello');
    },

    get getter() {
        return this.prop;
    },

    set setter(val) {
        this.prop = val;
    },

}


obiekt.nowaMetoda = function() {
    console.log('To jest nowa metoda.');
  };

obiekt.nowePole = "abc";

Object.defineProperty(obiekt, 'newProp', {
    value: "newPropVal",
    writable: true
});


Object.defineProperty(obiekt, 'newFunction', {
    value: function() {
        return "newFuction";
    }
});

Object.defineProperty(obiekt, 'newMethods', {
    get: function() {
        return this.newProp;
    },
    set: function(val) {
        this.newProp = val;
    }
});

console.log(obiekt.nowePole)