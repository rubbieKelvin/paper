import os

FILES = []
IGNORE = []


def fetchfiles(path):

	conts = os.listdir(path)

	for cont in conts:
		absolutepath = os.path.join(path, cont)
		relativepath = os.path.relpath(absolutepath, start=path)

		valid = not relativepath in IGNORE
		valid &= not os.path.split(relativepath)[-1] in IGNORE

		if os.path.isfile(absolutepath):
			valid &= not os.path.splitext(absolutepath)[-1] in IGNORE

		if valid:
			if os.path.isdir(absolutepath):
				fetchfiles(absolutepath)
			elif os.path.isfile(absolutepath):
				FILES.append(relativepath)

def main(qrc, root=os.getcwd(), ignore=[], prefix="/"):
	root = os.path.abspath(root)
	fetchfiles(root)

	xml = """<RCC>
	<qresource prefix="{prefix}">
		{files}
	</qresource>\n</RCC>""".format(
		prefix=prefix,
		files="\n\t\t".join(
			[
				"<file>{file}</file>".format(
					file=file
				) for file in FILES
			]
		)
	)

	with open(qrc, "w") as file:
		file.write(xml)
