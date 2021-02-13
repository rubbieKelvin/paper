class Color{
	constructor(aplha){
		this.aplha = aplha || "";
	}

	get primary () {
		return `#${this.aplha}4460F1`;
	}

	get textdark() {
		return `#${this.aplha}1A1A1A`;
	}

	get strokegray() {
		return `#${this.aplha}EaEaEa`;
	}
}