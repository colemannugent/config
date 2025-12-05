function open-edits
	# Get all staged and unstaged modified files, excluding deletions
	set -l files (begin
		git diff --name-only --diff-filter=ACM
		git diff --name-only --staged --diff-filter=ACM
		git ls-files --others --exclude-standard
	end | sort -u)

	if test (count $files) -gt 0
		# Open them all in one nvim session (tabs by default)
		nvim -p $files
	else
		echo "No modified files to open."
	end
end
