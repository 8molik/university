function Foo() {
    this.Bar = function() {
        Qux();
    }
    function Qux(){
        console.log("qux")
    }
}

var f = new Foo()

f.Bar();
//f.Qux();
