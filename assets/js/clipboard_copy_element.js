// Mainly from github view_components/primer/clipboard-copy-component
import "@github/clipboard-copy-element"

const duration = 2000
const clipboardCopyElementTimers = new WeakMap()

document.addEventListener("clipboard-copy", function ({ target }) {
  console.log(target)
  if (!(target instanceof HTMLElement)) return

  const currentTimeout = clipboardCopyElementTimers.get(target)

  if (currentTimeout) {
    clearTimeout(currentTimeout)
  } else {
    toggleCopyButton(target)
  }

  clipboardCopyElementTimers.set(
    target,
    setTimeout(timerCallback, duration, target)
  )
})

// Toggle a copy button.
function toggleCopyButton(button) {
  clipboardCopyElementTimers.delete(button)
  const [clippyIcon, checkIcon] = button.querySelectorAll('.icon')

  if (!clippyIcon || !checkIcon) return

  toggleSVG(clippyIcon)
  toggleSVG(checkIcon)
}

function toggleSVG(svg) {
  if (svg.style.display === "" || svg.style.display === "block") {
    svg.style.display = "none"
  } else {
    svg.style.display = "block"
  }
}

function timerCallback(target) {
  clipboardCopyElementTimers.delete(target)
  toggleCopyButton(target)
}
