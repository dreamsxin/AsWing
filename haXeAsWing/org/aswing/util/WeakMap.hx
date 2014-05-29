package org.aswing.util;


class WeakMap<K:{}, V> implements Map.IMap<K, V> {
    public function new():Void {
        throw "Not implemented for this platform";
    }

    public function set(key:K, value:V):Void {
    }

    public function get(key:K):Null<V> {
        return null;
    }

    public function exists(key:K):Bool {
        return false;
    }

    public function remove(key:K):Bool {
        return false;
    }

    public function keys():Iterator<K> {
        return null;
    }

    public function iterator():Iterator<V> {
        return null;
    }

    public function toString():String {
        return null;
    }
}