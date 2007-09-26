package org.aswing.guibuilder{

import org.aswing.JPanel;
import org.aswing.LayoutManager;
import org.aswing.JTree;
import org.aswing.JButton;
import org.aswing.BorderLayout;
import org.aswing.JScrollPane;

public class HiberarchyPane extends JPanel{
	
	private var tree:JTree;
	private var addButton:JButton;
	private var removeButton:JButton;
	private var upButton:JButton;
	private var downButton:JButton;
	private var leftButton:JButton;
	private var rightButton:JButton;
	
	public function HiberarchyPane(){
		super();
		
		//creating
		tree = new JTree();
		addButton = new JButton("Add com");
		addButton.setToolTipText("Add a component");
		removeButton = new JButton("Remove me");
		removeButton.setToolTipText("Remove selected component");
		upButton = new JButton("↑");
		upButton.setToolTipText("Move up");
		downButton = new JButton("↓");
		downButton.setToolTipText("Move down");
		leftButton = new JButton("←");
		leftButton.setToolTipText("Move to parent's parent");
		rightButton = new JButton("→");
		rightButton.setToolTipText("Move to first container brother");
		
		//layouting
		setLayout(new BorderLayout());
		append(new JScrollPane(tree), BorderLayout.CENTER);
		var bottom:JPanel = new JPanel();
		bottom.appendAll(addButton, removeButton, upButton, downButton, leftButton, rightButton);
		append(bottom, BorderLayout.SOUTH);
		
		setOperatable(false);
	}
	
	public function setOperatable(b:Boolean):void{
		addButton.setEnabled(b);
		removeButton.setEnabled(b);
		upButton.setEnabled(b);
		downButton.setEnabled(b);
		leftButton.setEnabled(b);
		rightButton.setEnabled(b);
	}
	
	public function getTree():JTree{
		return tree;
	}
	
	public function getAddButton():JButton{
		return addButton;
	}
	
	public function getRemoveButton():JButton{
		return removeButton;
	}
	
	public function getUpButton():JButton{
		return upButton;
	}
	
	public function getDownButton():JButton{
		return downButton;
	}
	
	
	public function getLeftButton():JButton{
		return leftButton;
	}
	
	public function getRightButton():JButton{
		return rightButton;
	}
}
}