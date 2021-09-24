class mEncoder {
  alphabets = ["Z", "X", "V", "T", "R", "P", "N", "L", "J", "A"];
  numbers = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"];

  constructor() {}

  remove_number(num) {
    let list = [];
    for (const s of num) {
      var data = this.numbers.includes(s);
      if (data) {
        if (s >= 1) list.push(s - 1);
        else list.push(9);
      }
    }

    return list;
  }

  isAvnumber(num) {
    for (const s of num) {
      var data = this.numbers.includes(s);
      if (!data) {
        return false;
      }
    }
    return true;
  }

  remove_string(str) {
    let list = [];
    for (const s of str) {
      var data = this.alphabets.includes(s);
      if (data) list.push(s);
    }

    return list;
  }

  isAvstring(str) {
    for (const s of str) {
      var data = this.alphabets.includes(s);
      if (!data) {
        return false;
      }
    }
    return true;
  }

  tonumbers(str) {
    let list = [];
    let d = this.remove_string(str);
    for (const l of d) {
      const newLocal = this.alphabets.indexOf(l) + 1;
      if (newLocal == 10) list.push(0);
      else list.push(newLocal);
    }
    var l = "";
    list.forEach((element) => {
      l = l + element;
    });
    return l;
  }

  tostrings(num) {
    let list = [];
    let item = this.remove_number(num);

    for (const l of item) {
      const newLocal = this.alphabets[l];
      if (newLocal == 10) list.push(0);
      else list.push(newLocal);
    }
    var l = "";
    list.forEach((element) => {
      l = l + element;
    });
    return l;
  }
}

let mClass = new mEncoder();
//console.log("xZALJA");
//console.log(mClass.tonumbers("zlertwwg".toUpperCase()));
//console.log("rpnal");
//console.log(mClass.tonumbers("rpnal".toUpperCase()));
//console.log("1234");
//console.log(mClass.tostrings("12360"));
//console.log("6789");
//console.log(mClass.tostrings("6789"));
