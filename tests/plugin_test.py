import os
import sys
import unittest

sys.path.append(
	os.path.join(
		"..", "src"
	)
)

from paper.lib.qjsonstorage import QmlEncryptedJSONStorage6

class QmlEncryptedJSONStorage6TestCase (unittest.TestCase):
	def test_parse_filename(self):
		self.assertEqual(0, 0)

if __name__ == "__main__":
	unittest.main()