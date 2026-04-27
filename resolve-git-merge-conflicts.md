# ✅ Key Steps to Resolve Merge Conflicts in Visual Studio

Based on Microsoft’s official documentation, these are the essential
steps:
[\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/visualstudio/version-control/git-resolve-conflicts?view=visualstudio)

### **1. Detect the conflict**

Visual Studio alerts you to merge conflicts when:

-   Pulling changes
-   Merging branches  
    Conflicted files appear in the **Git Changes** window under
    *Unmerged Changes*.

### **2. Open the Merge Editor**

To begin resolving conflicts:

-   Double‑click a file with conflicts  
    **or**
-   If the file is open, select **Open Merge Editor**

### **3. Choose how to resolve each conflict**

Inside the Merge Editor, you have several options:

-   **Take Incoming**  
    Accept all changes coming from the other branch.

-   **Take Current**  
    Keep your local version of all conflicting changes.

-   **Line‑by‑line resolution**  
    Check individual sections from either side to construct the final
    version.

-   **Manual editing**  
    Edit the *Result* pane directly.

### **4. Accept the merge**

After resolving the conflict:

-   Click **Accept Merge**
-   Repeat for each conflicted file

### **5. Commit the resolution**

Once all conflicts are cleared:

-   Stage the resolved files
-   Commit the merge

# 🖥️ Understanding the Merge Editor View

According to Microsoft’s documentation, Visual Studio’s Merge Editor
provides a structured, visual layout to help you compare and resolve
differences.
[\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/visualstudio/version-control/git-resolve-conflicts?view=visualstudio)

### **Three main sections:**

Visual Studio’s merge interface uses a **3‑pane layout** (similar to
other Git tools):

### **1. Current (Yours)**

-   Shows the version of the file from your local branch.
-   Represents your in‑progress changes.

### **2. Incoming (Theirs)**

-   Shows the version coming from the branch you’re merging into your
    branch.
-   Represents changes made by others or by the upstream branch.

### **3. Result (Output)**

-   Displayed in the center (or bottom, depending on layout).
-   This is the final content of the file after your resolution
    decisions.
-   You can manually edit this pane.

### **Additional features:**

-   **Checkboxes** next to each conflicting block allow easy selection
    (take left, take right).
-   **Take Incoming** and **Take Current** buttons allow one‑click full
    acceptance.
-   **Gear menu** lets you switch layouts (e.g., vertical view).
-   Visual markers clearly indicate each conflict region.

This editor is specifically designed to make the decisions explicit and
to ensure you understand exactly what you are merging.

## 🎥 Recommended Video Tutorials

### **1. “The EASIEST Way to Resolve Git Merge Conflicts (Visual Studio)” — YouTube**

A clear, practical walkthrough of handling merge conflicts inside Visual
Studio, including step‑by‑step merging, conflict resolution, and
committing your changes.  
🔗 <https://www.youtube.com/watch?v=USoGIUbcKk4>
[\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **2. “How to Fix Merge Conflicts in Visual Studio 2026” — Benjamin Day Consulting**

Shows a full conflict scenario, demonstrates the Visual Studio merge
editor, explains Current vs. Incoming vs. Result panes, and walks
through manual conflict resolution.  
🔗
<https://www.benday.com/blog/github-for-beginners-7-how-to-fix-merge-conflicts-in-visual>
[\[benday.com\]](https://www.benday.com/blog/github-for-beginners-7-how-to-fix-merge-conflicts-in-visual)

Here’s a clear, beginner‑friendly summary of the YouTube video **“The
EASIEST Way to Resolve Git Merge Conflicts (Visual Studio)”**, along
with the most important takeaways for someone just getting started.
[\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

# 🎥 **Summary of the Beginner Video**

The video walks viewers through the basics of resolving Git merge
conflicts **inside Visual Studio**, focusing on clarity and simplicity
rather than deep Git internals.

Here’s what it covers:

### **1. What a Merge Conflict Is (Beginner Explanation)**

The video explains that merge conflicts happen when Git can’t
automatically combine changes between two branches—usually because the
same lines of code were modified differently in each branch.
[\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **2. How to Start the Merge**

The presenter demonstrates:

-   Switching to the target branch
-   Running a `git merge` (through Visual Studio’s UI or Git commands)
-   Triggering a conflict intentionally so the viewer can see the
    process
    [\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **3. How Visual Studio Shows Conflicts**

Visual Studio flags files with conflicts and guides users to the merge
editor. The video highlights how friendly and visual the interface is
for beginners.
[\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **4. Using Visual Studio’s Merge Tools**

The tutorial then shows:

-   Side‑by‑side comparison
-   Selecting which version to keep
-   Editing the final result directly
-   Understanding the “Current,” “Incoming,” and “Result” panes
    [\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **5. Finalizing the Merge**

Once conflicts are resolved:

-   The user commits the merge
-   The project returns to a clean state
    [\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

The tone is slow, clear, and designed for beginners who may not fully
understand Git yet.

# ⭐ **Key Takeaways for Beginners**

### **1. Merge Conflicts Are Normal**

Conflicts don’t mean something is broken—they happen when two sets of
changes overlap.
[\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **2. Visual Studio Makes Conflict Resolution Easier**

Instead of editing markers (`<<<<<<<` etc.) manually, Visual Studio
provides:

-   Buttons for taking one side
-   A clear 3‑pane editor
-   Visual differences
    [\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **3. You Always Have Three Views**

Understanding these is crucial:

-   **Current (Yours)**: Your version
-   **Incoming (Theirs)**: The other branch’s version
-   **Result**: The final merged file you’re constructing
    [\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **4. You Control the Final Outcome**

You can:

-   Accept all your changes
-   Accept all incoming changes
-   Mix and match line by line
-   Manually edit the merged result
    [\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

### **5. Always Test After Resolving**

The video emphasizes committing the merge and ensuring everything still
compiles and works afterward.
[\[youtube.com\]](https://www.youtube.com/watch?v=USoGIUbcKk4)

Below is a **beginner-friendly Git merge‑conflict checklist** plus a
**guided practice scenario** you can try directly in Visual Studio.  
All concepts and steps are aligned with how Visual Studio detects and
resolves merge conflicts.
[\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/visualstudio/version-control/git-resolve-conflicts?view=visualstudio)

# ✅ **Beginner Merge‑Conflict Checklist (Visual Studio)**

Use this as a step‑by‑step guide whenever you encounter a merge
conflict.

## **🔹 1. Before You Merge**

-   Pull the latest changes from the remote.
-   Make sure your working directory is clean (no uncommitted changes).
-   Ensure you’re on the branch you want to merge *into* (usually your
    feature branch).  
    *(Visual Studio will show your current branch in the status bar.)*

## **🔹 2. Start the Merge**

-   Go to **Git → Branches**
-   Right‑click the branch you want to merge *from* (e.g., `main`)
-   Select **Merge Into Current Branch**

If a conflict occurs, Visual Studio will notify you immediately.  
Conflicted files appear in **Git Changes → Unmerged Changes**.
[\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/visualstudio/version-control/git-resolve-conflicts?view=visualstudio)

## **🔹 3. Open the Merge Editor**

-   Double‑click each conflicted file  
    **or**
-   Open the file and click **Open Merge Editor**

This brings up the 3‑pane merge editor:

-   **Current (Yours)**
-   **Incoming (Theirs)**
-   **Result (Output)**
    [\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/visualstudio/version-control/git-resolve-conflicts?view=visualstudio)

## **🔹 4. Resolve Conflicts Using the Merge Editor**

For each conflicted block:

-   Choose **Take Current** to keep your branch’s change
-   Choose **Take Incoming** to take the other branch’s change
-   Select individual lines manually
-   Or edit the **Result** pane directly

Use whichever approach makes the code correct.
[\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/visualstudio/version-control/git-resolve-conflicts?view=visualstudio)

## **🔹 5. Finalize the Merge**

-   Click **Accept Merge** in the editor.
-   Repeat for every conflicted file until all conflicts are resolved.
-   Stage and commit the merge.

## **🔹 6. After the Merge**

-   Build and run your solution to confirm everything works.
-   Push your merge commit to the remote.

# 🎯 **Practice Scenario for Beginners**

Here’s a simple, safe scenario you can try inside Visual Studio to learn
conflict resolution.

## **Scenario Setup**

You will intentionally create a merge conflict between two branches.

### **Step 1: Create a New Repo**

1.  Open Visual Studio
2.  Create a **new Console App**
3.  Initialize Git (if not already done)

## **Step 2: Create a Feature Branch**

-   Go to **Git → Branches**
-   Create a new branch named: feature/update-message
-   Switch to it.

## **Step 3: Edit Program.cs in the Feature Branch**

Open `Program.cs` and update the main print line:

    Console.WriteLine("Hello from the feature branch!");

Save and commit:

    Updated greeting in feature branch

## **Step 4: Switch Back to Main**

-   Switch to `main` branch.

## **Step 5: Edit the Same Line Differently**

In `Program.cs` on `main`, change the line to:

    Console.WriteLine("Hello from the main branch!");

Save and commit:

    Updated greeting in main branch

Now both branches changed **the same line** — this guarantees a merge
conflict.

## **Step 6: Merge and Trigger a Conflict**

While still on `main`:

-   Go to **Git → Branches**
-   Right‑click `feature/update-message`
-   Select **Merge into Current Branch**

Visual Studio will report the conflict and list the file under
**Unmerged Changes**.
[\[learn.microsoft.com\]](https://learn.microsoft.com/en-us/visualstudio/version-control/git-resolve-conflicts?view=visualstudio)

## **Step 7: Resolve the Conflict in the Merge Editor**

When the Merge Editor opens:

-   On the left is **Current (Yours)** → main branch version
-   On the right is **Incoming (Theirs)** → feature branch version
-   In the center is the **Result** pane

Choose one:

-   **Take Current** (keep main)
-   **Take Incoming** (keep feature)
-   Combine them manually in the Result pane:

<!-- -->

    Console.WriteLine("Hello from both branches!");

Then click **Accept Merge**.

## **Step 8: Finish**

-   Stage and commit the merge
-   Run the project to confirm the output
-   Push the merge commit to the remote

Here you go — a **clean one‑page cheat sheet** you can keep handy,
followed by a **more advanced multi‑file practice scenario** to build
confidence with real‑world merge‑conflict situations.

# 📄 **Quick Reference: Visual Studio Git Merge Conflict Cheat Sheet**

## **1. Before You Merge**

-   ✔ Pull latest changes
-   ✔ Make sure all your work is committed
-   ✔ Switch to the branch you want to merge *into*

## **2. Start the Merge**

**Git → Branches → Right‑click branch → Merge Into Current**

Visual Studio alerts you if conflicts occur:

-   Conflicts appear under **Git Changes → Unmerged Changes**

## **3. Open the Merge Editor**

-   Double‑click any conflicted file
-   Or open the file and select **Open Merge Editor**

## **4. Understanding the 3‑Pane Merge Editor**

-   **Current (Yours):** Your branch’s code
-   **Incoming (Theirs):** The branch you’re merging in
-   **Result (Output):** Final merged file you are building

## **5. Resolving Conflicts**

Use any of these options:

### **Buttons**

-   **Take Current:** Keep your version
-   **Take Incoming:** Keep the other version
-   **Both / Individual lines:** Mix changes line‑by‑line
-   **Manual edit:** Edit directly in the Result pane

## **6. Complete the Merge**

-   Click **Accept Merge** in each file
-   Stage changes
-   Commit the merge
-   Build & test
-   Push the merge commit

# 🧪 **Practice Scenario: Multi‑File Merge Conflict Exercise**

This exercise simulates a real‑project conflict involving multiple files
— ideal for practicing more complex resolutions.

# **Scenario Overview**

You’ll create:

-   A **main** branch
-   A **feature/refactor‑utilities** branch

Then you’ll trigger conflicts across **three files**:

1.  `Program.cs`
2.  `Utilities/MathUtils.cs`
3.  `Utilities/StringUtils.cs`

# **📁 Step 1 — Create the Project Structure**

Create a new Console App. Then add two directory‑based utility classes:

    /Utilities
        MathUtils.cs
        StringUtils.cs
    Program.cs

Add simple placeholder content to both utility files.

# **🌿 Step 2 — Commit the Initial Version (main branch)**

Commit initial code for all three files.

# **🌿 Step 3 — Create Feature Branch**

Create a new branch:

    feature/refactor-utilities

Switch to it.

# **✏ Step 4 — Make Changes on feature/refactor-utilities**

### **Program.cs**

Change the main message:

    Console.WriteLine("Starting enhanced utilities...");

### **MathUtils.cs**

Modify or rename a method:

    public static int Add(int a, int b) => a + b + 10;

### **StringUtils.cs**

Adjust a method:

    public static string Upper(string input) => input.ToUpper() + "!";

Commit changes.

# **🌿 Step 5 — Switch Back to main**

Now change *the same lines* in all three files — but differently.

### **Program.cs**

    Console.WriteLine("Starting system...");

### **MathUtils.cs**

    public static int Add(int a, int b) => a + b;

### **StringUtils.cs**

    public static string Upper(string input) => input.ToUpperInvariant();

Commit these main‑branch edits.

Now all three files have conflicting changes.

# **🔀 Step 6 — Merge Feature Branch into main**

While on `main`:

-   **Git → Branches**
-   Right‑click: `feature/refactor-utilities`
-   Select: **Merge Into Current Branch**

Visual Studio will report conflicts on all three files.

# **🛠 Step 7 — Resolve in Merge Editor**

For each file:

### Options to practice:

-   Try “Take Current” for one file
-   Try “Take Incoming” for the second
-   Try manually merging line‑by‑line for the third

This gives exposure to:

-   Quick merge decisions
-   Visual comparison
-   Manual merge for nuanced changes

# **🏁 Step 8 — Finalize**

-   Click **Accept Merge** for each file
-   Stage changes
-   Commit merge
-   Run project to confirm everything works
-   Push the final merge commit

Below is a clear, **step‑by‑step guide** on how to resolve Git merge
conflicts using **TortoiseGit + Beyond Compare**, based entirely on
verified documentation and configuration instructions.

# ✅ **1. How Merge Conflicts Work in TortoiseGit**

When a conflict occurs during a merge, rebase, or cherry‑pick,
TortoiseGit marks the file and provides three versions of each
conflicted file:

-   **BASE** – the common ancestor
-   **LOCAL (Yours)** – your working tree version
-   **REMOTE (Theirs)** – the version from the branch you’re merging in
    [\[tortoisegit.org\]](https://tortoisegit.org/docs/tortoisegit/tgit-dug-conflicts.html)

You can resolve manually or launch an external merge tool using
**TortoiseGit → Edit Conflicts**.
[\[tortoisegit.org\]](https://tortoisegit.org/docs/tortoisegit/tgit-dug-conflicts.html)

# ✅ **2. Setting Up Beyond Compare as the Merge Tool in TortoiseGit**

Beyond Compare does *not* auto‑configure itself, so you must set it
explicitly via TortoiseGit’s settings.

### **Steps (Windows):**

1.  Right‑click any folder → **TortoiseGit → Settings**
2.  Go to **Diff Viewer**
3.  Change from **TortoiseGitMerge** to **External**
4.  Set the command to Beyond Compare’s path, such as:

<!-- -->

    "C:\Program Files\Beyond Compare 5\bcomp.exe" %base %mine /lefttitle="%bname" /righttitle="%yname"

[\[stackoverflow.com\]](https://stackoverflow.com/questions/71823135/unable-to-use-diff-viewer-merge-tool-using-tortoisegit-2-13-and-beyond-compare)

1.  Go to **Merge Tool**
2.  Set external tool path, for example:

<!-- -->

    "C:\Program Files\Beyond Compare 5\bcomp.exe" %mine %theirs %base /mergeoutput=%merged /lefttitle="%yname" /righttitle="%tname" /centertitle="%bname"

[\[stackoverflow.com\]](https://stackoverflow.com/questions/71823135/unable-to-use-diff-viewer-merge-tool-using-tortoisegit-2-13-and-beyond-compare)

You can also find official, detailed recommendations for Beyond Compare
diff/merge commands from Scooter Software’s documentation.
[\[scootersoftware.com\]](https://www.scootersoftware.com/support.php?zz=kb_vcs)

# ✅ **3. Resolving a Merge Conflict Using TortoiseGit + Beyond Compare**

### **Step 1 — Initiate the Merge**

Use TortoiseGit:  
Right‑click repo → **TortoiseGit → Merge**  
If Git encounters conflicts, TortoiseGit will flag them.

### **Step 2 — Open the Conflict Resolution Dialog**

A list of conflicted files will appear.  
Double‑click a file → TortoiseGit opens the external merge tool (Beyond
Compare). [\[How to Res…rtoise
Git\]](http://jordantechwriter.com/resources/How%20to%20Resolve%20Merge%20Conflicts%20in%20Tortoise%20Git.pdf)

### **Step 3 — Use Beyond Compare’s 3‑Way Merge Interface**

Beyond Compare presents:

-   **Yours (LOCAL)** — your version
-   **Theirs (REMOTE)** — the incoming version
-   **BASE** — common ancestor
-   **Merged Output** — final result

Your job is to pick or mix changes on each panel.

### **Step 4 — Resolve Conflicts**

In Beyond Compare you can:

-   Click **Take Left**, **Take Right**, or **Combine** chunks
-   Manually edit the merged output
-   Navigate conflict blocks using arrows

### **Step 5 — Save & Mark Resolved**

1.  Save the merged file in Beyond Compare
2.  Close Beyond Compare
3.  In TortoiseGit, click **Mark as Resolved** or **Resolved**  
    (This performs a `git add` to mark resolution.)
    [\[tortoisegit.org\]](https://tortoisegit.org/docs/tortoisegit/tgit-dug-conflicts.html)

### **Step 6 — Commit the Merge**

Commit the resolved merge inside TortoiseGit. [\[How to Res…rtoise
Git\]](http://jordantechwriter.com/resources/How%20to%20Resolve%20Merge%20Conflicts%20in%20Tortoise%20Git.pdf)

# 📌 **4. Example Workflow Summary**

1.  Attempt merge → Conflict appears
2.  Open conflicted file → Beyond Compare launches
3.  Compare LOCAL/REMOTE/BASE visually
4.  Edit final merged output
5.  Save, return to TortoiseGit
6.  Mark Resolved → Commit

Here’s a video tutorial demonstrating merge conflict resolution using
**TortoiseGit** (though not Beyond Compare specifically, it’s still
useful):  
🔗 *Mastering Git Merging with TortoiseGit* (YouTube)
[\[youtube.com\]](https://www.youtube.com/watch?v=Ajt-4MKb7Tk)

# 🎥 **A Video Showing Beyond Compare for Git Merge Conflicts**

While many videos demonstrate Git merge conflicts generally, the
following YouTube video **specifically mentions and shows Beyond Compare
used as a merge tool**:

### **🔗 How do you use Beyond Compare? — SN Develops (YouTube)**

This video covers:

-   How Beyond Compare works
-   3‑way merge concepts
-   How to use it for resolving Git merge conflicts
-   How Beyond Compare supports branch merging
    [\[youtube.com\]](https://www.youtube.com/watch?v=654jK3OmjEs)

👉 **Link:**  
<https://www.youtube.com/watch?v=654jK3OmjEs>

# 🧪 **Practice Scenario: TortoiseGit + Beyond Compare (Multi‑File Conflict)**

This scenario simulates a realistic multi‑file conflict resolution
workflow using **TortoiseGit** (as the Git client) and **Beyond
Compare** (as the diff/merge tool).

It is built based on how TortoiseGit handles conflicts and how Beyond
Compare is used as the external merge tool.
[\[youtube.com\]](https://www.youtube.com/watch?v=t_OPySus5bE),
[\[stackoverflow.com\]](https://stackoverflow.com/questions/71823135/unable-to-use-diff-viewer-merge-tool-using-tortoisegit-2-13-and-beyond-compare),
[\[stackoverflow.com\]](https://stackoverflow.com/questions/76863825/how-to-bring-up-the-merge-tool-to-resolve-conflicts-in-visual-studio-2022)

## \## 📁 **Project Setup**

Create a folder and initialize a repo containing:

    /src
       app.js
       math.js
       user.js
    README.md

Initial content:

**app.js**

    console.log("App starting...");

**math.js**

    export function add(a, b) { return a + b; }

**user.js**

    export const getUser = () => "Anonymous";

Commit these on `main`.

# 🌿 **Step 1 — Create a Feature Branch**

Create a branch:

    feature/refactor

Switch to it.

# ✏ **Step 2 — Make Changes on feature/refactor**

Modify *all three* files to guarantee conflicts:

### app.js

    console.log("App initialized with refactored module system...");

### math.js

    export function add(a, b) { return a + b + 100; }

### user.js

    export const getUser = () => "RefactorUser";

Commit changes.

# 🌿 **Step 3 — Switch Back to main**

Now modify the same lines differently:

### app.js

    console.log("App starting in production mode...");

### math.js

    export function add(a, b) { return a - b; }

### user.js

    export const getUser = () => "ProdUser";

Commit these changes.

Now **all three files contain intentional merge conflicts**.

# 🔀 **Step 4 — Merge feature/refactor into main**

In Windows Explorer:

-   Right‑click repo folder
-   **TortoiseGit → Merge**
-   Select `feature/refactor`
-   Run merge

TortoiseGit will show conflicts in:

-   `app.js`
-   `math.js`
-   `user.js`

[\[youtube.com\]](https://www.youtube.com/watch?v=t_OPySus5bE)

# 🛠 **Step 5 — Resolve Each File Using Beyond Compare**

### For each conflicted file:

1.  Right‑click the file → **TortoiseGit → Edit Conflicts**
2.  TortoiseGit launches **Beyond Compare** as the configured merge
    tool  
    (using your %mine / %theirs / %base paths).
    [\[stackoverflow.com\]](https://stackoverflow.com/questions/76863825/how-to-bring-up-the-merge-tool-to-resolve-conflicts-in-visual-studio-2022)

### Inside Beyond Compare (3‑way merge):

-   **Left panel:** LOCAL (Your version)
-   **Right panel:** REMOTE (Their version)
-   **Center:** BASE (Common ancestor)
-   **Bottom merge panel:** Final output

You can:

-   Choose *Take Left* (your branch)
-   Choose *Take Right* (incoming branch)
-   Combine both sides
-   Edit the merged output manually

[\[stackoverflow.com\]](https://stackoverflow.com/questions/71823135/unable-to-use-diff-viewer-merge-tool-using-tortoisegit-2-13-and-beyond-compare)

## 🧩 Resolve each file differently to build skill:

### **app.js**

Try combining both messages manually:

    console.log("App starting in production mode with refactored module system...");

### **math.js**

Try “Take Incoming” to keep the refactor:

    export function add(a, b) { return a + b + 100; }

### **user.js**

Try “Take Current” (main branch):

    export const getUser = () => "ProdUser";

# 🏁 **Step 6 — Finalize the Merge**

For each file:

-   Save in Beyond Compare
-   Close Beyond Compare
-   In TortoiseGit, click **Mark as Resolved** (runs `git add`)
    [\[youtube.com\]](https://www.youtube.com/watch?v=t_OPySus5bE)

Finally:

-   Commit the merge
-   Push to remote

Here’s a **hands‑on, realistic SQL‑focused merge‑conflict practice
scenario** designed specifically for **TortoiseGit + Beyond Compare**.  
You’ll intentionally trigger conflicts across multiple `.sql` files so
you can practice resolving them visually with Beyond Compare.

# 🧪 **Practice Scenario: SQL Files + TortoiseGit + Beyond Compare**

This simulation mirrors what often happens in real database‑driven
projects:  
multiple developers modify stored procedures, schema scripts, or data
seed files at the same time.

You will work with three SQL files:

    /db
       01_create_tables.sql
       02_seed_data.sql
       03_update_procs.sql

# ✅ **1. Create a Repository and SQL Files**

Initialize a Git repo and add the following files with this initial
content:

### **01\_create\_tables.sql**

    CREATE TABLE Users (
        UserId INT PRIMARY KEY,
        UserName NVARCHAR(100),
        CreatedAt DATETIME DEFAULT GETDATE()
    );

### **02\_seed\_data.sql**

    INSERT INTO Users (UserId, UserName)
    VALUES (1, 'Alice'), (2, 'Bob');

### **03\_update\_procs.sql**

    CREATE OR ALTER PROCEDURE GetUserById
        @UserId INT
    AS
    BEGIN
        SELECT UserId, UserName
        FROM Users
        WHERE UserId = @UserId;
    END;

Commit on `main`.

# 🌿 **2. Create a Feature Branch**

Create:

    feature/add-email-column

Switch to it.

# ✏ **3. Modify SQL Files on the Feature Branch**

### **01\_create\_tables.sql**

Add an Email column:

    ALTER TABLE Users ADD Email NVARCHAR(200) NULL;

### **02\_seed\_data.sql**

Update seed data:

    INSERT INTO Users (UserId, UserName, Email)
    VALUES (1, 'Alice', 'alice@example.com'),
           (2, 'Bob',   'bob@example.com');

### **03\_update\_procs.sql**

Modify stored procedure to return Email:

    CREATE OR ALTER PROCEDURE GetUserById
        @UserId INT
    AS
    BEGIN
        SELECT UserId, UserName, Email
        FROM Users
        WHERE UserId = @UserId;
    END;

Commit changes.

# 🌿 **4. Switch Back to main and Create Conflicts**

Modify the same lines, *but differently*, to create guaranteed
conflicts.

### **01\_create\_tables.sql**

Another developer adds a PhoneNumber column instead:

    ALTER TABLE Users ADD PhoneNumber NVARCHAR(50) NULL;

### **02\_seed\_data.sql**

They add more users instead of modifying existing rows:

    INSERT INTO Users (UserId, UserName)
    VALUES (3, 'Carol'),
           (4, 'Dave');

### **03\_update\_procs.sql**

They add an ORDER BY clause instead of adding Email:

    CREATE OR ALTER PROCEDURE GetUserById
        @UserId INT
    AS
    BEGIN
        SELECT UserId, UserName
        FROM Users
        WHERE UserId = @UserId
        ORDER BY UserName;
    END;

Commit changes.

Now all SQL files contain direct conflicts.

# 🔀 **5. Merge Feature Branch into main**

Right‑click repo folder → **TortoiseGit → Merge**  
Choose `feature/add-email-column`.

You will now see conflicts in each SQL file.

# 🛠 **6. Resolve SQL Merge Conflicts Using Beyond Compare**

For each file:

1.  Right‑click → **TortoiseGit → Edit Conflicts**

2.  Beyond Compare opens with:

    -   **Left** = LOCAL (main branch)
    -   **Right** = REMOTE (feature branch)
    -   **Center / Top** = BASE
    -   **Bottom** = final merged output

3.  Perform conflict resolution following the suggestions below.

# 🧩 **Recommended Conflict Resolutions**

### **A. 01\_create\_tables.sql — combine changes**

Merge both new columns:

    ALTER TABLE Users
        ADD Email NVARCHAR(200) NULL,
            PhoneNumber NVARCHAR(50) NULL;

Practice:

-   Use Beyond Compare to take *both* sides
-   Or manually create combined version in the merge panel

### **B. 02\_seed\_data.sql — merge AND keep consistency**

You want both the updated seed data *and* the new users.

Suggested merged version:

    INSERT INTO Users (UserId, UserName, Email)
    VALUES (1, 'Alice', 'alice@example.com'),
           (2, 'Bob',   'bob@example.com');

    INSERT INTO Users (UserId, UserName)
    VALUES (3, 'Carol'),
           (4, 'Dave');

Practice:

-   Accept either side partially
-   Combine manually in the merged output

### **C. 03\_update\_procs.sql — combine logic from both branches**

Merged version:

    CREATE OR ALTER PROCEDURE GetUserById
        @UserId INT
    AS
    BEGIN
        SELECT UserId, UserName, Email
        FROM Users
        WHERE UserId = @UserId
        ORDER BY UserName;
    END;

Practice:

-   Keep Email from feature branch
-   Keep ORDER BY from main
-   Manually combine in merge output

# 🏁 **7. Finalize the Merge**

For each file:

-   Save in Beyond Compare
-   Close it
-   In TortoiseGit click **Mark as Resolved**
-   Commit the merge

You can determine which **remote Git repository** your local project is
connected to using a few simple Git commands. Here are the most common
methods:

# 🔍 **1. Show all configured remotes**

Run:

    git remote -v

This lists all remotes (usually just `origin`) along with their
**fetch** and **push** URLs.

Example output:

    origin  https://github.com/yourname/yourrepo.git (fetch)
    origin  https://github.com/yourname/yourrepo.git (push)

This tells you exactly *which* remote repository your local repository
is pointing to.

# 🔧 **2. Show detailed remote configuration**

If you want more detail:

    git remote show origin

This shows:

-   The remote URL
-   The HEAD branch
-   Which branches track which remote branches
-   Push/pull configuration

Example snippet:

    * remote origin
      Fetch URL: https://github.com/yourname/yourrepo.git
      Push  URL: https://github.com/yourname/yourrepo.git
      HEAD branch: main

# 🛠 **3. From TortoiseGit**

If you’re using **TortoiseGit**:

1.  Right‑click your local repository folder
2.  Go to **TortoiseGit → Settings**
3.  Select **Git** → **Remote**

You’ll see all remotes and their URLs.

# 🧩 **4. View** `.git/config` **directly**

You can also inspect the configuration file:

    .git/config

Look for:

    [remote "origin"]
        url = https://github.com/yourname/yourrepo.git
        fetch = +refs/heads/*:refs/remotes/origin/*

# ✅ **Check Your Azure DevOps Remote (Command Line)**

Run:

    git remote -v

You’ll typically see something like:

    origin  https://dev.azure.com/YourOrg/YourProject/_git/YourRepo (fetch)
    origin  https://dev.azure.com/YourOrg/YourProject/_git/YourRepo (push)

or the older format:

    origin  https://YourOrg@dev.azure.com/YourOrg/YourProject/_git/YourRepo

This shows your connected Azure DevOps repository URL.

*(This method works for any remote and is the standard Git way.)*

# 🔧 **Get More Remote Details**

Run:

    git remote show origin

This displays:

-   The Azure DevOps remote URL
-   The remote HEAD branch
-   Tracking branch information
-   Push/pull settings

# 🐢 **Check Azure DevOps Remote in TortoiseGit**

1.  Right‑click your repository folder
2.  Select **TortoiseGit → Settings**
3.  Go to **Git → Remote**

There you’ll see remotes like:

    origin → https://dev.azure.com/YourOrg/YourProject/_git/YourRepo

Based on TortoiseGit documentation, remotes are stored and resolved
through standard Git config, so the remote list is visible directly
under **Settings → Git → Remote**.
[\[tortoisegit.org\]](https://tortoisegit.org/docs/tortoisegit/tgit-dug-conflicts.html)

# 📄 **View the URL in** `.git/config`

Open `.git/config` and look for:

    [remote "origin"]
        url = https://dev.azure.com/YourOrg/YourProject/_git/YourRepo

This file is where TortoiseGit also reads the remote configuration.  
TortoiseGit documentation explains Git remotes (including
“mine/theirs/remote” concepts) using the same Git config structure.
[\[tortoisegit.org\]](https://tortoisegit.org/docs/tortoisegit/tgit-dug-conflicts.html)

# 🔐 **Azure DevOps Remote URL Patterns**

Azure DevOps Git remotes always look like one of these:

### **New format (recommended):**

    https://dev.azure.com/{organization}/{project}/_git/{repo}

### **Legacy Visual Studio Online format:**

    https://{organization}.visualstudio.com/{project}/_git/{repo}

### **With embedded username (older authentication method):**

    https://{username}@dev.azure.com/{organization}/{project}/_git/{repo}

If your remote matches one of these, you’re connected to Azure DevOps.

# 🧭 Want to Change the Azure DevOps Remote?

You can update it with:

    git remote set-url origin https://dev.azure.com/YourOrg/YourProject/_git/YourRepo
