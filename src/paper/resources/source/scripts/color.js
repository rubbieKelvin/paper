class Color{
	constructor(alpha){
		this.alpha = alpha || "";
	}

	get primary () {
		return `#${this.alpha}4460F1`;
	}

	get textdark() {
		return `#${this.alpha}1A1A1A`;
	}

	get strokegray() {
		return `#${this.alpha}EaEaEa`;
	}

	get danger() {
		return `#${this.alpha}f44336`;
	}
}