contract C {
    function g(bytes memory revertMsg) public pure returns (uint, uint) {
        assembly { revert(add(revertMsg, 0x20), mload(revertMsg)) }
    }
    function f1() public returns (uint x) {
        // Invalid signature
        try this.g(abi.encodeWithSelector(0x12345678, uint(0), uint(0), uint(0))) returns (uint a, uint b) {
            return 0;
        } catch Error(string memory) {
            return 1;
        } catch (bytes memory) {
            return 2;
        }
    }
    function f1a() public returns (uint x) {
        // Invalid signature
        try this.g(abi.encodeWithSelector(0x12345678, uint(0), uint(0), uint(0))) returns (uint a, uint b) {
            return 0;
        } catch Error(string memory) {
            return 1;
        } catch {
            return 2;
        }
    }
    function f2() public returns (uint x) {
        // Valid signature but illegal offset
        try this.g(abi.encodeWithSignature("Error(string)", uint(0x100), uint(0), uint(0))) returns (uint a, uint b) {
            return 0;
        } catch Error(string memory) {
            return 1;
        } catch (bytes memory) {
            return 2;
        }
    }
    function f2a() public returns (uint x) {
        // Valid signature but illegal offset
        try this.g(abi.encodeWithSignature("Error(string)", uint(0x100), uint(0), uint(0))) returns (uint a, uint b) {
            return 0;
        } catch Error(string memory) {
            return 1;
        } catch {
            return 2;
        }
    }
    function f3() public returns (uint x) {
        // Valid up to length
        try this.g(abi.encodeWithSignature("Error(string)", uint(0x20), uint(0x30), uint(0))) returns (uint a, uint b) {
            return 0;
        } catch Error(string memory) {
            return 1;
        } catch (bytes memory) {
            return 2;
        }
    }
    function f3a() public returns (uint x) {
        // Valid up to length
        try this.g(abi.encodeWithSignature("Error(string)", uint(0x20), uint(0x30), uint(0))) returns (uint a, uint b) {
            return 0;
        } catch Error(string memory) {
            return 1;
        } catch (bytes memory) {
            return 2;
        }
    }
    function f4() public returns (uint x) {
        // Fully valid
        try this.g(abi.encodeWithSignature("Error(string)", uint(0x20), uint(0x7), bytes7("abcdefg"))) returns (uint a, uint b) {
            return 0;
        } catch Error(string memory) {
            return 1;
        } catch (bytes memory) {
            return 2;
        }
    }
    function f4a() public returns (uint x) {
        // Fully valid
        try this.g(abi.encodeWithSignature("Error(string)", uint(0x20), uint(0x7), bytes7("abcdefg"))) returns (uint a, uint b) {
            return 0;
        } catch Error(string memory) {
            return 1;
        } catch {
            return 2;
        }
    }
}
// ----
// f1() -> 2
// f1a() -> 2
// f2() -> 2
// f2a() -> 2
// f3() -> 2
// f3a() -> 2
// f4() -> 1
// f4a() -> 1
