# Setting Up Posit Assistant in RStudio for CUNY Biostatistics 2 (CUNYBIOS2)

This guide provides step-by-step instructions for configuring **Posit Assistant** inside RStudio to connect to the free CUNY AI Lab (CAIL) service. When combined with the course context file ([`AGENTS.md`](AGENTS.md)), Posit Assistant acts as an interactive learning assistant tailored to the materials of this course. These instructions guide it to be a helpful learning assistant without answering questions for you and to adhere to materials of this course rather than the Internet at large as an uninstructed model will do.

---

## Part 1: Initial Setup in RStudio (One-Time Configuration)

### Step 1: Enable Posit Assistant in RStudio
1. In the RStudio menu bar, go to **Tools** → **Global Options...**
2. In the left options list, click on **Assistant**.
3. Under the **Chat** section:
   - Set **Chat provider** to: `Posit Assistant` (from the dropdown menu).
   - Check the box: `[x] Show Posit Assistant button in toolbar`.
4. Click **Apply**, then **OK**.

### Step 2: Open Posit Assistant & Access Provider Settings
1. Click the **"Posit Assistant"** icon in the top-right toolbar of RStudio (or switch to the **Assistant** tab in your sidebar).
2. In the top-right corner of the Posit Assistant chat pane, click the **gearbox icon** (⚙).
3. Select **"Configure AI providers"** from the dropdown menu.

### Step 3: Connect to the CUNY AI Lab (CAIL) Endpoint
1. In the **AI Providers** list, scroll down to the bottom and locate **`OpenAI Compatible`**.
2. Click **Connect** (or **Edit** if already connected).
3. Fill in the fields:
   - **Base URL**: `https://tools.ailab.gc.cuny.edu/v1`
   - **API Key (optional)**: Paste your assigned `CAIL_API_KEY` (starts with `sk-...`).
4. Click the **Test** button to confirm connectivity.
5. Click **Save**, then click **Close** (or **Refresh models**).

### Step 4: Select the Recommended Model
In the Posit Assistant chat panel, click the model selection dropdown at the bottom:
- **Recommended Default**: **`google/gemini-2.5-flash`** (or **`openai/gpt-4o-mini`**)
- **Important**: **Do NOT select `qwen/qwen3-32b` or models ending in `-thinking`**. These share an upstream free pool subject to severe concurrency rate limits (`HTTP 429`) with this free service, and their internal reasoning tokens can exhaust the output length and truncate your code answers.

---

## Part 2: Activating the Course Persona via `AGENTS.md`

Posit Assistant automatically reads a file named **`AGENTS.md`** in your current R working directory or project root. When present, it automatically includes the course curriculum, diagnostic guidelines, and teaching rules in its system prompt. This will help it stick to the course content, without bringing in exotic or unhelpful alternatives.

### If Working in the Course Repository:
If you have cloned or downloaded the `cunybios2` repository and opened `CUNYBIOS2.Rproj` in RStudio, [`AGENTS.md`](AGENTS.md) is already in the project root. Posit Assistant will automatically detect and load it!

### If Working in a Separate Folder:
If you are working in a standalone directory or personal homework project, download `AGENTS.md` into your current working directory by running this single line in your RStudio console:

```R
download.file(
  url = "https://raw.githubusercontent.com/waldronbios2/cunybios2/main/AGENTS.md",
  destfile = "AGENTS.md"
)
```

You can view the full course rules and session guidelines in [`AGENTS.md`](AGENTS.md).

---

## Part 3: Tips for Students Working on Labs

1. **Highlighting Code in Editor**: You can highlight lines in your R script or R Markdown file, right-click, and select **Assistant: Explain Code** or ask specific questions about the highlighted lines.
2. **Debugging Errors**: When an error occurs in your console, copy and paste the line of code that triggered it along with the error message into the Assistant pane. The assistant will guide you to inspect data objects (`str()`, `table()`, `levels()`) and understand the error.
3. **Interpreting Results**: Paste your model summary output (e.g., from `summary(fit)`) and ask: *"Can you explain what the coefficient and p-value for the interaction term mean in this model?"*
4. **Learning vs. Solution Asking**: Posit Assistant is configured as a pedagogical TA; it will guide your understanding, prompt you with diagnostic questions, and help you evaluate model assumptions rather than merely providing unexamined answers.
