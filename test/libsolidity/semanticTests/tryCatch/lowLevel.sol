contract C {
    function g(bool b) public pure returns (uint, uint) {
        require(b, "message");
        return (1, 2);
    }
    function f(bool b) public returns (uint x, uint y, bytes memory txt) {
        try this.g(b) returns (uint a, uint b) {
            (x, y) = (a, b);
        } catch (bytes memory s) {
            txt = s;
        }
    }
}
// ----
// f(bool): true -> 1, 2, 96, 0
// f(bool): false -> 0, 0, 96, 100, 3963877391197344453575983046348115674221700746820753546331534351508065746944, 862718293348820473429344482784628181556388621521298319395315527974912, 200240400974129698026711077260797157360650913022725854495054588018688, 0
