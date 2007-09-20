package org.aswing.guibuilder.model{

import flash.display.DisplayObject;
import flash.display.Sprite;
import org.aswing.tree.*;
import org.aswing.event.*;
import org.aswing.util.ArrayUtils;	

/**
 * UI File Model
 * @author iiley
 */
public class FileModel implements TreeModel{
	
	private var name:String;
	private var root:ComModel;
	private var canvas:Sprite;
	private var listenerList:Array;
	
	public function FileModel(root:ComModel, name:String){
		this.root = root;
		this.name = name;
		canvas = new Sprite();
		canvas.mouseEnabled = false;
		canvas.addChild(root.getDisplay());
		listenerList = new Array();
	}
	
	public function getDisplay():DisplayObject{
		return canvas;
	}
	
	public function getRootComponent():ComModel{
		return root;
	}
	
	public function getName():String{
		return name;
	}
	
	public function toString():String{
		return name;
	}
	
	//_____________________________TreeModel Imp_______________________________
	
    /**
     * Returns the root of the tree.  Returns <code>null</code>
     * only if the tree has no nodes.
     *
     * @return  the root of the tree
     */
    public function getRoot():Object{
    	return root;
    }


    /**
     * Returns the child of <code>parent</code> at index <code>index</code>
     * in the parent's
     * child array.  <code>parent</code> must be a node previously obtained
     * from this data source. This should not return <code>null</code>
     * if <code>index</code>
     * is a valid index for <code>parent</code> (that is <code>index >= 0 &&
     * index < getChildCount(parent</code>)).
     *
     * @param   parent  a node in the tree, obtained from this data source
     * @return  the child of <code>parent</code> at index <code>index</code>
     */
    public function getChild(parent:Object, index:int):Object{
    	var m:ComModel = parent as ComModel;
    	return m.getChild(index);
    }


    /**
     * Returns the number of children of <code>parent</code>.
     * Returns 0 if the node
     * is a leaf or if it has no children.  <code>parent</code> must be a node
     * previously obtained from this data source.
     *
     * @param   parent  a node in the tree, obtained from this data source
     * @return  the number of children of the node <code>parent</code>
     */
    public function getChildCount(parent:Object):int{
    	var m:ComModel = parent as ComModel;
    	return m.getChildCount();
    }


    /**
     * Returns <code>true</code> if <code>node</code> is a leaf.
     * It is possible for this method to return <code>false</code>
     * even if <code>node</code> has no children.
     * A directory in a filesystem, for example,
     * may contain no files; the node representing
     * the directory is not a leaf, but it also has no children.
     *
     * @param   node  a node in the tree, obtained from this data source
     * @return  true if <code>node</code> is a leaf
     */
    public function isLeaf(node:Object):Boolean{
    	var m:ComModel = node as ComModel;
    	return m.getChildCount() == 0;
    }

    /**
      * Messaged when the user has altered the value for the item identified
      * by <code>path</code> to <code>newValue</code>. 
      * If <code>newValue</code> signifies a truly new value
      * the model should post a <code>treeNodesChanged</code> event.
      *
      * @param path path to the node that the user has altered
      * @param newValue the new value from the TreeCellEditor
      */
    public function valueForPathChanged(path:TreePath, newValue:Object):void{
    	
    }

    /**
     * Returns the index of child in parent.  If either <code>parent</code>
     * or <code>child</code> is <code>null</code>, returns -1.
     * If either <code>parent</code> or <code>child</code> don't
     * belong to this tree model, returns -1.
     *
     * @param parent a note in the tree, obtained from this data source
     * @param child the node we are interested in
     * @return the index of the child in the parent, or -1 if either
     *    <code>child</code> or <code>parent</code> are <code>null</code>
     *    or don't belong to this tree model
     */
    public function getIndexOfChild(parent:Object, child:Object):int{
    	var m:ComModel = parent as ComModel;
    	return m.getChildIndex(child);
    }

    //
    //  Events
    //

    /**
     * Adds a listener for the TreeModelEvent posted after the tree changes.
     *
     * @see     #removeTreeModelListener
     * @param   l       the listener to add
     */
    public function addTreeModelListener(l:TreeModelListener):void {
        listenerList.push(l);
    }

    /**
     * Removes a listener previously added with <B>addTreeModelListener()</B>.
     *
     * @see     #addTreeModelListener
     * @param   l       the listener to remove
     */  
    public function removeTreeModelListener(l:TreeModelListener):void {
    	ArrayUtils.removeFromArray(listenerList, l);
    }

    /**
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node being changed
     * @param path the path to the root node
     * @param childIndices the indices of the changed elements
     * @param children the changed elements
     * @see EventListenerList
     */
    private function fireTreeNodesChanged(source:Object, path:Array, 
                                        childIndices:Array, 
                                        children:Array):void {
        var listeners:Array = listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (var i:int = listeners.length-1; i>=0; i--) {
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, new TreePath(path), childIndices, children);
            }
            var lis:TreeModelListener = TreeModelListener(listeners[i]);
            lis.treeNodesChanged(e);   
        }
    }

    /**
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node where new elements are being inserted
     * @param path the path to the root node
     * @param childIndices the indices of the new elements
     * @param children the new elements
     * @see EventListenerList
     */
    private function fireTreeNodesInserted(source:Object, path:Array, 
                                        childIndices:Array, 
                                        children:Array):void {
        var listeners:Array = listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (var i:int = listeners.length-1; i>=0; i--) {
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, new TreePath(path), childIndices, children);
            }
            var lis:TreeModelListener = TreeModelListener(listeners[i]);
            lis.treeNodesInserted(e);
        }
    }

    /**
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node where elements are being removed
     * @param path the path to the root node
     * @param childIndices the indices of the removed elements
     * @param children the removed elements
     * @see EventListenerList
     */
    private function fireTreeNodesRemoved(source:Object, path:Array, 
                                        childIndices:Array, 
                                        children:Array):void {
        var listeners:Array = listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (var i:int = listeners.length-1; i>=0; i--) {
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, new TreePath(path), childIndices, children);
            }
            var lis:TreeModelListener = TreeModelListener(listeners[i]);
            lis.treeNodesRemoved(e);
        }
    }

    /**
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node where the tree model has changed
     * @param path the path to the root node
     * @param childIndices the indices of the affected elements
     * @param children the affected elements
     * @see EventListenerList
     */
    private function fireTreeStructureChanged(source:Object, path:Array, 
                                        childIndices:Array, 
                                        children:Array):void {
        var listeners:Array = listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (var i:int = listeners.length-1; i>=0; i--) {
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, new TreePath(path), childIndices, children);
            }
            var lis:TreeModelListener = TreeModelListener(listeners[i]);
            lis.treeStructureChanged(e);
        }
    }

    /*
     * Notifies all listeners that have registered interest for
     * notification on this event type.  The event instance 
     * is lazily created using the parameters passed into 
     * the fire method.
     *
     * @param source the node where the tree model has changed
     * @param path the path to the root node
     * @see EventListenerList
     */
    private function fireTreeStructureChanged2(source:Object, path:TreePath):void {
        var listeners:Array = listenerList;
        var e:TreeModelEvent = null;
        // Process the listeners last to first, notifying
        // those that are interested in this event
        for (var i:int = listeners.length-1; i>=0; i--) {
            // Lazily create the event:
            if (e == null){
                e = new TreeModelEvent(source, path);
            }
            var lis:TreeModelListener = TreeModelListener(listeners[i]);
            lis.treeStructureChanged(e);
        }
    }
		
}
}