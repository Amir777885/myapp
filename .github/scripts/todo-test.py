import sys
import unittest
from io import StringIO
from todo import Task, TaskPool


class TestTaskPool(unittest.TestCase):
    def setUp(self):
        self.pool = TaskPool()

    def test_add_task(self):
        self.pool.add_task(Task("New task"))
        self.assertEqual(len(self.pool.tasks), 1)

    def test_get_open_tasks(self):
        self.pool.populate()
        open_titles = [t.title for t in self.pool.get_open_tasks()]
        self.assertIn("Configure CI workflow", open_titles)
        self.assertEqual(len(open_titles), 3)

    def test_get_done_tasks(self):
        self.pool.populate()
        done_titles = [t.title for t in self.pool.get_done_tasks()]
        self.assertIn("Set up repository", done_titles)
        self.assertEqual(len(done_titles), 3)


if __name__ == "__main__":
    suite = unittest.TestLoader().loadTestsFromTestCase(TestTaskPool)
    stream = StringIO()
    result = unittest.TextTestRunner(stream=stream, verbosity=2).run(suite)
    for line in stream.getvalue().splitlines():
        if line.endswith("... ok"):
            print(line.split(" (")[0] + " ... ok")
        elif "FAIL" in line or "ERROR" in line:
            print(line)
    print(f"Ran {result.testsRun} tests: {'OK' if result.wasSuccessful() else 'FAILED'}")
    sys.exit(0 if result.wasSuccessful() else 1)
