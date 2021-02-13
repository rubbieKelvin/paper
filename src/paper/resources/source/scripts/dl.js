class Item{
	constructor (component, parent, props) {
		this.parent = parent;
		this.props = props;
		
		this.component = component;
		this._item = null;

		if (this.component.status === Component.Ready) this.finish();
		else this.component.statusChanged.connect(this.finish);
	}

	get item () {
		return this._item;
	}

	finish(){
		if (this.component.status === Component.Ready){
			
			this._item = this.component.createObject(this.parent, this.props);
			if (this._item === null) console.log("error creating object");

		}else if (this.component.status === Component.Error){
			console.error("error creating component", this.component.errorString());
		}
	}
}
