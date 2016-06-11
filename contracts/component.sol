contract Component {
    ComponentManager _manager;
    function Component(ComponentManager manager) {
        _manager = manager;
    }
    modifier auth {
        if (!_manager.isRoot(msg.sender)) {
            throw;
        }
        _
    }
}
contract ComponentManager {
    mapping(address=>bool) _is_root;
    mapping(bytes32=>bytes32) _env;
    function ComponentManager() {
        _is_root[msg.sender] = true;
    }
    function isRoot(address who) constant returns (bool) {
        return _is_root[who];
    }
    function getEnv(bytes32 key) constant returns (bytes32 value) {
        return _env[key];
    }
    function setEnv(bytes32 key, bytes32 value) {
        if(!isRoot(msg.sender)) throw;
        _env[key] = value;
    }
    function setRoot(address who, bool is_root) {
        if(!isRoot(msg.sender)) throw;
        _is_root[who] = is_root;
    }
}

